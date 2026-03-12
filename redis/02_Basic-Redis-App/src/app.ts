import axios from "axios";
import express, { Response } from "express";

// initialize express app
const app = express();

// configure port
const port = process.env.PORT || 3000;

// routes
app.get("/", async (_, res: Response) => {
  const { data } = await axios.get(
    "https://jsonplaceholder.typicode.com/todos",
  );
  return res.json(data);
});

// run app
app.listen(port, () => {
  console.log(`Server running locally on port ${port}`);
});
