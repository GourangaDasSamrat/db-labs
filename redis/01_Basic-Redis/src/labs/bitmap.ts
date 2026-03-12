import redisClient from "@/client";

const init = async () => {
  // set bit
  const setBit = await redisClient.setbit("pings:2026-01-01-00:00", 123, 1);
  console.log("setBit result =>", setBit);

  // set bit
  const getBit = await redisClient.getbit("pings:2026-01-01-00:00", 123);
  console.log("getBit result =>", getBit);
};

init();
