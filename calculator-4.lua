-------------------------------------------------------------
-- Cuarta parte: construir una simple calculadora.
-- Esta versión es un Recursive Descend Parsing
-- o Análisis de descenso recursivo.
--
-- aplica la siguiente gramática:
-- expression 	::= term (('+' | '-') term)*
-- term			::= factor (('*' | '/') factor)*
-- factor		::= number
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

function Calculator:factor()
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

function Calculator:multiply()
	self:matchAndEat('*')
	return self:factor()
end

function Calculator:divide()
	self:matchAndEat('/')
	return self:divide()
end

function Calculator:term()
	local result = self:factor()
	while self.look == '*' or self.look == '/' do
		if self.look == '*' then
			result = result * self:multiply()
		else
			result = result / self:divide()
		end
	end
	return result
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
	local expression = "9*3-1+8*5-7"
	print("Expression: " .. expression)
	local calc = Calculator:new(expression)
	calc:init()
	local result = calc:arithmeticExpression()
	print("Calculation Result: " .. result)
end

main() -- caller
