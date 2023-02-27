var express = require("express");
var router = express.Router();

router.get("/", (req, res) => {
    res.send("Modules are working properly");
});

module.exports = router;