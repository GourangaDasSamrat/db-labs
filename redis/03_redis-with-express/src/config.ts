export const MONGO_URI =
  process.env.MONGODB_URI ?? 'mongodb://127.0.0.1:27017/myapp';
export const REDIS_URL = process.env.REDIS_URI ?? 'redis://127.0.0.1:6379';
export const APP_PORT = Number(process.env.PORT ?? 3000);
