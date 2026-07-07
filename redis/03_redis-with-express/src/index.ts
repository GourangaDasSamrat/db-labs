import { APP_PORT } from "@/config";
import { connectMongo } from "@/db/mongo";
import createRedisClient from "@/db/redis";
import express from "express";

const app = express();
app.use(express.json());

app.get("/", (_req, res) => res.json({ status: "ok" }));

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
