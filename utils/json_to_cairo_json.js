function json_to_cairo_json(obj, res_arr) {
  keys = Object.keys(obj);
  obj_handler(obj, keys, res_arr);
  res_arr.pop();
  return res_arr;
}

function obj_handler(obj, keys, res_arr) {
  for (let i = 0; i <= keys.length; i++) {
    if (i === keys.length) {
      res_arr.push("*");
      break;
    }

    res_arr.push(keys[i]);
    if (typeof obj[keys[i]] !== "object") res_arr.push(obj[keys[i]]);
    if (typeof obj[keys[i]] === "object") {
      res_arr.push("_");
      obj_handler(obj[keys[i]], Object.keys(obj[keys[i]]), res_arr);
    }
  }
}
