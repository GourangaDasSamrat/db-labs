import { RedisClient } from 'bun';
import { REDIS_URL } from '@/config';

let redisClient: RedisClient | null = null;

export async function createRedisClient(url = REDIS_URL): Promise<RedisClient> {
  if (redisClient) return redisClient;

  try {
    redisClient = new RedisClient(url);
    console.log('Connected to Redis via Bun');
    return redisClient;
  } catch (err) {
    console.error('Failed to connect to Redis:', err);
    throw err;
  }
}

export function getRedisClient(): RedisClient {
  if (!redisClient) {
    throw new Error('Redis client is not initialized!');
  }
  return redisClient;
}

export type { RedisClient };
export default createRedisClient;
