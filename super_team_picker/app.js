const express = require("express");
const logger = require("morgan");
const path = require("path");
const methodOverride = require("method-override");
const cohortsRouter = require("./routes/cohorts");
const rootRouter = require("./routes/root");

const app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger("dev"));
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

app.use(methodOverride((req, res) => {
  if (req.body && req.body._method) {
    const method = req.body._method;
    return method;
  };
}));

app.use("/cohorts", cohortsRouter);
app.use("/", rootRouter);

const PORT = 3000;
const ADDRESS = "localhost";
app.listen(PORT, ADDRESS, () => {
  console.log(`listening on ${ADDRESS}:${PORT}`);
});
