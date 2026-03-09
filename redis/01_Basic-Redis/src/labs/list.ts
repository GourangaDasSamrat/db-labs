import redisClient from "@/client";

const init = async () => {
  // insert from left side
  //  const lPush = await redisClient.lpush("messages", "I love you");
  //  console.log("LPush result =>", lPush);

  // insert from right side
  // const rPush = await redisClient.rpush("messages", "How are you");
  // console.log("RPush result =>", rPush);

  // remove from left side
  // const lPop = await redisClient.lpop("messages");
  // console.log("LPop result =>", lPop);

  // remove from left side
  // const rPop = await redisClient.rpop("messages");
  // console.log("LPop result =>", rPop);

  // list length
  // const lLen = await redisClient.llen("messages");
  // console.log("LLen result =>", lLen);

  // blocking left pop -> its like lpop, its remove key from left side but difference between lop and blpop is if there is no element lop return null (in shell nil), but blop wait the time we set timeout, in that time if any value add its remove that, if not its also return null
  // const bLPop = await redisClient.blpop("messages", 10); // timeout in seconds
  // console.log("BLPop result =>", bLPop);

  // read list -> first number is where to start and 2nd is where to stop, here 0 means start from first and -1 means to last of the list, its return an array
  // const lRange = await redisClient.lrange("messages", 0, -1);
  // console.log("LRange result =>", lRange);
};

init();
