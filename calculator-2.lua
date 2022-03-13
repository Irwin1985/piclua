-------------------------------------------------------------
-- Segunda parte: construir una simple calculadora.
-- Esta versión mejora un poco pero sigue siendo impráctica.
-- Aquí se muestra el uso del método arithmeticExpression()
-- que se encarga de leer 1 operando, un operador y otro
-- operando.
-------------------------------------------------------------
local Calculator = {
	expression 			= "",
	currentCharPosition = 1, -- primer caracter
	Look 				= ""
}

function Calculator:new(exp)
	local c = {}
	setmetatable(c, self)
	self.__index = self
	c.expression = exp
	
	return c
end

function Calculator:getChar()
	local pos = self.currentCharPosition
	if pos <= #self.expression then
		self.look = string.sub(self.expression, pos, pos)
	end
	self.currentCharPosition = self.currentCharPosition + 1
end

function Calculator:getNum()
	local number = tonumber(self.look)
	self:getChar()
	return number
end

function Calculator:init()
	self:getChar()
end

function Calculator:matchAndEat(chr)
	if self.look == chr then
		self:getChar()
	else
		error("Error: Unexpected character.")
		os.exit(1)
	end	
end

function Calculator:term()
	return self:getNum()
end

function Calculator:add()
	self:matchAndEat('+')
	return self:term()
end

function Calculator:subtract()
	self:matchAndEat('-')
	return self:term()
end

function Calculator:arithmeticExpression()
	local result = self:term()
	if self.look == '+' then
		result = result + self:add()
	elseif self.look == '-' then
		result = result - self:subtract()
	end
	return result
end

---------------------------------------------------------------
-- main
---------------------------------------------------------------
function main()
	local expression = "5-2"
	local calc = Calculator:new(expression)
	calc:init()
	print(calc:arithmeticExpression())
end

main() -- caller
