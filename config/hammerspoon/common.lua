local serpent = require("serpent")

function pf(tab)
  return serpent.block(tab, {nocode = true})
end

function pp(tab)
  print(pf(tab))
end

function withself(obj, func)
  return function (...)
    return func(obj, ...)
  end
end

function rgb256(r, g, b, alpha)
  alpha = alpha or 1.0
  return {red = r / 256, green = g / 256, blue = b / 256, opacity = alpha}
end
