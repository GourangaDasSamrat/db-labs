import client from "@/client";
import axios from "axios";
import express, { Response } from "express";

const app = express();
const port = process.env.PORT || 3000;

app.get("/", async (_, res: Response) => {
  const cacheValue = await client.get("todos");

  if (cacheValue) {
    return res.json(JSON.parse(cacheValue)); // parse cached data
  }

  const { data } = await axios.get(
    "https://jsonplaceholder.typicode.com/todos",
  );

  await client.set("todos", JSON.stringify(data)); // convert to string
  await client.expire("todos", 100);

  return res.json(data);
});

app.listen(port, () => {
  console.log(`Server running locally on port ${port}`);
});
