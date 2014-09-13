program SimplifyFraction;

// frac1_zdvm.pas	Зотиков Д.Ю., Высоков М.Г. сентябрь 2014
//
// Сокращение обыкновенной дрови вида m/n, где
// m - целое, n - целое без знака.
// Проверяется корректность введенных значений.
//
// Compile and run with: cls && fpc -Mobjfpc frac1_zdvm.pas && frac1_zdvm.exe


type
	Frac = record
		m: integer;
		n: longword;
	end;

function GetFrac(): Frac;
var
	x: Frac;
begin
	write('Введите через пробел m n (0 0 -- конец): ');
	try
		readln(x.m, x.n);
	except
		writeln('Input error');
		x := GetFrac();
	end;
	GetFrac := x;
end;

function GCDiv(m: integer; n: integer): integer;
begin
	if n = 0 then
		GCDiv := m
	else
		GCDiv := GCDiv(n, m mod n)
end;

procedure PutFrac(x: Frac);
var
	gcd: integer;
begin
	gcd := GCDiv(x.m, x.n);
	writeln('  ', x.m, '/', x.n, ' = ', (x.m / gcd):1:0, '/', (x.n / gcd):1:0);
end;

var
	x: Frac;
	usage: string;
begin
	// x := GetFrac();
	// writeln(x.m, '/', x.n);
	// x.m := 20;
	// x.n := 16;
	// writeln(GCD(x.m, x.n));
		writeln('*** frac1_zdvm.pas	Зотиков Д.Ю., Высоков М.Г. сентябрь 2014');
		writeln('*** Сокращение обыкновенной дрови вида m/n, где');
		writeln('*** m - целое, n - целое без знака.');
		writeln('*** Проверяется корректность введенных значений.');
		
		x := GetFrac();
			
		while (x.m <> 0) or (x.n <> 0) do
		begin
			PutFrac(x);
			x := GetFrac();
		end;
		writeln('Выполнение закончено.');
		readln();
end.