import redisClient from "@/client";

const init = async () => {
  // set add
  // const sAdd = await redisClient.sadd("ip", "192.168.0.5"); // if the member already exist its return 0, otherwise its return 1
  // console.log("sAdd result =>", sAdd);

  // set remove
  // const sRem = await redisClient.srem("ip", "192.168.0.2"); // if its usccesfully remove the member its return 1, otherwise its return 0
  // console.log("sRem result =>", sRem);

  // check set member
  // const sIsMember = await redisClient.sismember("ip", "192.168.0.1"); // if the member exist its return 1, otherwise its return 0
  // console.log("sIsMember result =>", sIsMember);
};

init();
