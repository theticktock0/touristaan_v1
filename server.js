const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const passport = require("passport");
const path = require("path");
const cors = require("cors");
const users = require("./routes/api/auth/users");
const userprofile = require("./routes/api/profile/userProfile");
const agencyprofile = require("./routes/api/profile/agencyProfile");
const posts = require("./routes/api/social/posts");
const trips = require("./routes/api/trip/trips");
const notification = require("./routes/api/social/notification");
const agency = require("./routes/api/auth/agency");
const message = require("./routes/api/social/message");
const location = require("./routes/api/trip/location");
const http = require("http");
// const userPayment = require('./routes/api/payment/userPayment')

mongoose.set("useFindAndModify", false);
const app = express();
// Body Parser Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// DB config
const db = require("./config/keys").mongoURI;

//Connect to MongoDB
mongoose
  .connect(db, {
    useFindAndModify: false,
    useUnifiedTopology: true,
    useNewUrlParser: true,
    useCreateIndex: true,
  })
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.log(err));

// Passport middleware
app.use(passport.initialize());

// Express Messages Middleware
app.use(require("connect-flash")());
app.use(function (req, res, next) {
  res.locals.messages = require("express-messages")(req, res);
  next();
});

// Passport Config
require("./config/passport")(passport);

// Use Routes
app.use("/api/users", users);
app.use("/api/userprofile", userprofile);
app.use("/api/agencyprofile", agencyprofile);

app.use("/api/posts", posts);
app.use("/api/trips", trips);

app.use("/api/agency", agency);
app.use("/api/messages", message);
app.use("/api/notification", notification);
app.use("/api/location", location);

// app.use("/api/user-payment", userPayment)

// app.use('/api/profile', profile);

// app.use('/api/admins', admins);
const port = process.env.PORT || 5000;
const server = http.createServer(app);

const io = require("socket.io")(server);

io.on("connect", (socket) => {
  console.log("We have new connection!!");
  socket.on("join");
  socket.on("disconnect", () => {
    console.log("User had left!!");
  });
});

if (process.env.NODE_ENV === "production") {
  app.use(express.static("client/build"));

  app.get("*", (req, res) => {
    res.sendFile(path.resolve(__dirname, "client", "build", "index.html"));
  });
}

server.listen(port, () => console.log(`Server running on port ${port}`));

// const Message = require("./model/Message");

// io.on("connection", (socket) => {
//   sendStatus = (s) => {
//     socket.emit("status", s);
//   };
//   socket.on(
//     "userData",
//     (data) => {
//       Message.find()
//         .sort({ _id: 1 })
//         .distinct("receiver", { sender: data.sender })
//         .then((messages) => {
//           socket.emit("receiveMessagesByUser", messages);
//         });
//     },
//     (err) => console.log(err.stack)
//   );

//   socket.on(
//     "data",
//     (data) => {
//       Message.find({
//         $and: [{ receiver: data.receiver }, { sender: data.sender }],
//       })
//         .sort({ _id: 1 })
//         .then((messages) => {
//           socket.emit("receiveAllMessages", messages);
//         });
//     },
//     (err) => console.log(err.stack)
//   );

//   socket.on("sendMessage", (data) => {
//     const {
//       name,
//       message,
//       sender,
//       receiver,
//       senderAvatar,
//       receiverAvatar,
//       text,
//     } = data;

//     if (name === "" || text === "") {
//       sendStatus("please enter name and message");
//     } else {
//       const newMessage = new Message({
//         name: name,
//         message: message,
//         sender: sender,
//         text: text,
//         receiver: receiver,
//         senderAvatar: senderAvatar,
//         receiverAvatar: receiverAvatar,
//       });

//       newMessage
//         .save()
//         .then((message) => socket.emit("receiveSentMessage", [message]));
//     }
//   });
// });
