const repl = require("repl");
const util = require("util");

repl.start({
  prompt: "> ",
  writer: (output) => {
    if (output === undefined) return "";
    return util.inspect(output, { colors: true, depth: null });
  },
});
