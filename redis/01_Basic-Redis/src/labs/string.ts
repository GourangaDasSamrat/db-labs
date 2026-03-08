import redisClient from "@/client";

const init = async () => {
  // set value
  // const setValue = await redisClient.set("user:6", "Piyush Garg");
  // console.log("Set value result =>", setValue);

  // set expire time
  // const setExpire = await redisClient.expire("user:2", 10);
  // console.log("Set expire result =>", setExpire);

  // get value
  // const getValue = await redisClient.get("user:5");
  // console.log("Get value result =>", getValue);

  // delete key
  // const deleteKey = await redisClient.del("user:5");
  // console.log("Delete Key result =>", deleteKey);
};

init();
