import mongoose from "mongoose";
import { MONGO_URI } from "@/config";

export async function connectMongo(uri = MONGO_URI) {
  mongoose.set("strictQuery", false);
  try {
    await mongoose.connect(uri);
    console.log("MongoDB connected");
    mongoose.connection.on("error", (err) =>
      console.error("MongoDB connection error:", err),
    );
    mongoose.connection.on("disconnected", () =>
      console.warn("MongoDB disconnected"),
    );
    return mongoose;
  } catch (err) {
    console.error("MongoDB connection failed:", err);
    throw err;
  }
}

export default mongoose;
