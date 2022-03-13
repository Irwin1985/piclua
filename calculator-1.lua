-------------------------------------------------------------
-- Primera parte: construir una simple calculadora.
-- Esta versión es extremadamente limitada y no es factible
-- para ningún uso ya que el análisis de la expresión se
-- realiza de forma manual.
--
-- Ejemplo: para la expresión "1+2" primero hay que invocar
-- getChar() => para salvar el primer operando
-- look 	 => para salvar el operador
-- getChar() => para salvar el segundo operado
-- 
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

---------------------------------------------------------------
-- main
---------------------------------------------------------------
function main()
	local expression = "1+2"
	local calc = Calculator:new(expression)
	calc:init()
	local firstNumber = calc:getNum()
	local operator = calc.look
	calc:getChar()
	local secondNumber = calc:getNum()
	print("First Number: " .. firstNumber)
	print("Operator: " .. operator)
	print("Second Number: " .. secondNumber)
	local sum = firstNumber + secondNumber
	print("SUM of Those Two Number: " .. sum)
end

main() -- caller
