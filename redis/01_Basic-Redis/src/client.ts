import Redis from "ioredis";

const connectionUri = process.env.REDIS_URI;

if (!connectionUri) throw new Error("Redis connection uri is not defined");

const client = new Redis(connectionUri);

export default client