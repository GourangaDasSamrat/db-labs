import redisClient from "@/client";

const init = async () => {
  // hash set
  /*
  const hSet = await redisClient.hset("player:1", {
    name: "Elena Rybakina",
    age: 26,
    nationality: "Kazakhstan",
    rank: 3,
  });
  console.log("hSet result =>", hSet);
*/

  // hash get
  // const hGet = await redisClient.hget("player:1", "name");
  // console.log("hGet result =>", hGet);

  // hash get all
  // const hGetAll = await redisClient.hgetall("player:1");
  // console.log("hGetAll result =>", hGetAll);

  // hash multiple get
  // const hMGet = await redisClient.hmget("player:1", "name", "age");
  // console.log("hMGet result =>", hMGet);

  // hash delete
  // const hDel = await redisClient.hdel("player:1", "age");
  // console.log("hDel result =>", hDel);
};

init();
