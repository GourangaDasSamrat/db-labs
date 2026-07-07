import { RedisClient } from 'bun';
import { REDIS_URL } from '@/config';

export async function createRedisClient(url = REDIS_URL): Promise<RedisClient> {
  try {
    const redis = new RedisClient(url);
    console.log('Connected to Redis via Bun');
    return redis;
  } catch (err) {
    console.error('Failed to connect to Redis:', err);
    throw err;
  }
}

export function getRedisClient() {
  const client = (global as any).__redis_client;
  if (!client) {
    throw new Error('Redis client is not initialized!');
  }
  return client;
}

export type { RedisClient };
export default createRedisClient;
