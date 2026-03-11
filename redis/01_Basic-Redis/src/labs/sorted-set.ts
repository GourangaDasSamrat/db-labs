import redisClient from "@/client";

const init = async () => {
  // sorted set add
  // const zAdd = await redisClient.zadd("point", 7253, "Elena Rybakina");
  // console.log("zAdd result =>", zAdd);

  // read set min 0 and max -1 means all members
  // const zRange = await redisClient.zrange("point", 0, -1);
  // console.log("zRange result =>", zRange);

  // read set in reverse order (max to min)
  // const zReverseRange = await redisClient.zrevrange("point", 0, -1);
  // console.log("zReverseRange result =>", zReverseRange);

  // read rank of specific member
  // const zRank = await redisClient.zrank("point", "Elina Svitolina");
  // console.log("zRank  result =>", zRank);

  // read rank of specific member in reverse order (max to min)
  // const zReverseRank = await redisClient.zrevrank("point", "Elina Svitolina");
  // console.log("zReverseRank  result =>", zReverseRank);
};

init();
