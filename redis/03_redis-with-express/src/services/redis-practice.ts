import createRedisClient, { getRedisClient } from '@/db/redis';
import { app } from '@/index';

export const redisPractice = () => {
  const ensureRedis = async () => {
    try {
      return getRedisClient();
    } catch (err) {
      await createRedisClient();
      return getRedisClient();
    }
  };

  // set value
  app.post('/set-cache', async (req, res) => {
    try {
      const { key, value } = req.body;

      let redis = await ensureRedis();

      try {
        await redis.set(key, JSON.stringify(value));
      } catch (err: any) {
        console.error('Redis set error, retrying:', err);
        if (err?.message?.includes('Connection has failed')) {
          await createRedisClient();
          redis = getRedisClient();
          await redis.set(key, JSON.stringify(value));
        } else {
          throw err;
        }
      }

      res.json({ success: true, message: `Key '${key}' saved to Redis.` });
    } catch (error: any) {
      console.error('Set-cache handler error:', error);
      res.status(500).json({ error: error.message });
    }
  });

  // get value
  app.get('/get-cache/:key', async (req, res) => {
    try {
      const { key } = req.params;

      let redis = await ensureRedis();

      let cachedData;
      try {
        cachedData = await redis.get(key);
      } catch (err: any) {
        console.error('Redis get error, retrying:', err);
        if (err?.message?.includes('Connection has failed')) {
          await createRedisClient();
          redis = getRedisClient();
          cachedData = await redis.get(key);
        } else {
          throw err;
        }
      }

      if (!cachedData) {
        return res.status(404).json({ message: 'Cache miss! No data found.' });
      }

      res.json({
        message: 'Cache hit!',
        data: JSON.parse(cachedData),
      });
    } catch (error: any) {
      res.status(500).json({ error: error.message });
    }
  });
};
