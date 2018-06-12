
require "dkl/DklRectCatAxis"


function setup() 
	size(1280,720)
	background(255)
	stroke(0);
	fill(0);
	fila = {}
	datos = {}
	x = {}
	y = {}
	local f = loadFont("data/Vera.ttf",14)
	textFont(f)
	
	local file = io.open("data.csv")
	
	while true do
		local line = file:read("*line")
		if line == nil then
			break
		end
		
		fila = {}
		line = string.sub(line,2,#(line)-1)
		for word in string.gmatch(line, '([^,]+)') do
			table.insert(fila,word)
		end
		table.insert(datos,fila)
		if member(x, fila[1]) == false then
			table.insert(x,fila[1])
		end
		
		if member(y, fila[2]) == false then
			table.insert(y,fila[2])
		end
		
		
		
		
	end
	table.remove(x, 1)
	table.remove(y, 1)
	table.remove(datos, 1)
	for i= 1, #(y) do
		print(y[i])
	end
end

function member(lista, palabra)
	miembro = false
	for i = 1, #(lista) do
		if lista[i] == palabra then
			miembro = true
			break
		end
	end
	return miembro		
end

function pos(dato, lista)
	for i = 1, #(lista) do
		if lista[i] == dato then
			return i
		end
	end
	return nil
end

function draw()
	
	background(255)
	local ycol = 200
	
	local etiqueta = datos[1][1]

	pushMatrix()
	translate(170,200)
	DklRectCatAxis(#(x)*40, LEFT, x, 20)
	popMatrix()
	pushMatrix()
	translate(170,200)
	DklRectCatAxis(#(y)*40, TOP, y, 20)
	popMatrix()
	
	local j = 1
	
	for i = 1, #(datos) do
		if datos[i][1] ~= etiqueta then
			ycol = ycol + 40
			etiqueta = datos[i][1]
			j = 1
		end
		xfila = 170 + (pos(datos[i][2], y)-1)*40
		if datos[i][3] ~= nil then
			if tonumber(datos[i][3])>1 then
				fill(61,219,61)
			elseif tonumber(datos[i][3])>0.85 then
				fill(226,137,48)
			else
				fill(63,63,191)
			end	
		else
			fill(63,63,191)
		end
		event(MOVED)
		local e = rect(xfila, ycol, 40, 40)
		if e then
			fill(171,178,185)
			rect(xfila, ycol, 40, 40)
			text("Valor:",95,650)
			if datos[i][3] ~= nil then
				text(datos[i][3],100,660)
			else 
				text("0",100,660)
			end
			
		end		
		j = j + 1
	end
end


	