-------------------------------------------------------------
-- Tercera parte: construir una simple calculadora.
-- Esta versión por primera vez refleja el uso de un
-- intérprete dirigido por sintaxis.
-- Se puede observar que el método arithmeticExpression()
-- aplica la regla gramatical 'term' para analizar las
-- siguientes expresiones: term ::= number (('+'|'-')number)*
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
	while self.look == '+' or self.look == '-' do
		if self.look == '+' then
			result = result + self:add()
		elseif self.look == '-' then
			result = result - self:subtract()
		end	
	end
	return result
end

---------------------------------------------------------------
-- main
---------------------------------------------------------------
function main()
	local expression = "9+2+5-3"
	local calc = Calculator:new(expression)
	calc:init()
	print(calc:arithmeticExpression())
end

main() -- caller
