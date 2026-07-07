import express from "express";
import { APP_PORT } from "./config";
import { connectMongo } from "./db/mongo";
import createRedisClient from "./db/redis";

const app = express();
app.use(express.json());

app.get("/", (_req, res) => res.json({ status: "ok" }));

app.get("/health", async (_req, res) => {
  const mongoose = await import("mongoose");
  const mongoState =
    mongoose.connection.readyState === 1 ? "connected" : "disconnected";
  let redisState = "unknown";
  try {
    // Try pinging redis depending on client
    const client = (global as any).__redis_client;
    if (!client) redisState = "not-initialized";
    else if (client.ping) {
      await client.ping();
      redisState = "connected";
    } else if (client.command) {
      await client.command("PING");
      redisState = "connected";
    } else redisState = "connected";
  } catch (err) {
    redisState = "disconnected";
  }

  res.json({ mongo: mongoState, redis: redisState });
});

async function start() {
  try {
    await connectMongo();
  } catch (err) {
    console.error("Failed to connect to MongoDB, exiting.", err);
    process.exit(1);
  }

  try {
    const redis = await createRedisClient();
    // store globally for simple access in this demo app
    (global as any).__redis_client = redis;
  } catch (err) {
    console.warn("Redis connection failed:", err);
  }

  app.listen(APP_PORT, () => console.log(`Server listening on ${APP_PORT}`));
}

start().catch((err) => {
  console.error("Failed to start app:", err);
  process.exit(1);
});
