import { RedisClient } from 'bun';
import { REDIS_URL } from '@/config';

let redisClient: RedisClient | null = null;

export async function createRedisClient(
  url = REDIS_URL,
  forceNew = false
): Promise<RedisClient> {
  if (redisClient && !forceNew) return redisClient;

  // If we're being asked to recreate the client (e.g. after a failed
  // connection), close the old socket first so it doesn't leak on the
  // Redis server / Upstash side.
  if (redisClient) {
    try {
      redisClient.close();
    } catch {
      // ignore - the old connection may already be dead
    }
    redisClient = null;
  }

  try {
    redisClient = new RedisClient(url);
    console.log('Connected to Redis via Bun');
    return redisClient;
  } catch (err) {
    console.error('Failed to connect to Redis:', err);
    throw err;
  }
}

// Explicitly close the client, e.g. on process shutdown / hot reload.
export function closeRedisClient() {
  if (redisClient) {
    try {
      redisClient.close();
    } catch {
      // ignore
    }
    redisClient = null;
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
