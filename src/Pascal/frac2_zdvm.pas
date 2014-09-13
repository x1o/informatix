program SimplifyFraction;

// frac2_zdvm.pas	Зотиков Д.Ю., Высоков М.Г. сентябрь 2014
//
// Сокращение обыкновенной дрови вида m/n, где
// m - целое, n - целое без знака.
// Проверяется корректность введенных значений.
//
// Compile and run with: cls && fpc -Mobjfpc frac2_zdvm.pas && frac2_zdvm.exe


uses
	SysUtils;

type
	Frac = record
		m: integer;
		n: longword;
	end;

function GetFrac(): Frac;
var
	x: Frac;
	flush_str: string;		// FIXME: KLUDGE!!!
begin
	write('Введите через пробел m n (0 0 -- конец): ');
	try
		readln(x.m, x.n);
	except
		writeln('Input error');
		readln(flush_str);
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

procedure PutFrac(x: Frac; var out_file: textfile);
var
	gcd: integer;
	out_str: string;
begin
	gcd := GCDiv(x.m, x.n);
	out_str := IntToStr(x.m) + '/' + IntToStr(x.n) + ' = ' + IntToStr(Round(x.m / gcd)) + '/' + IntToStr(Round(x.n / gcd));
	writeln(out_file, out_str);
	writeln('  ', out_str);
end;

var
	x: Frac;
	out_file: textfile;
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
	
	assignfile(out_file, 'frac2_zdvm.res');
	rewrite(out_file);
	
	x := GetFrac();
	while (x.m <> 0) or (x.n <> 0) do
	begin
		PutFrac(x, out_file);
		x := GetFrac();
	end;
	writeln('Выполнение закончено.');
	closefile(out_file);
	readln();
end.