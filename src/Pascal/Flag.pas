program Flag;

uses
	Graph;

const
	N = 3;

var
	gd, gm, h3, i: integer; 
	colours: array [1..N] of word;

begin
	gd := detect;
	InitGraph(gd, gm, ''); 
	h3 := GetMaxY div 3;

	colours[1] := black;
	colours[2] := red;
	colours[3] := yellow;

	for i:=1 to N do
	begin
		SetFillStyle(SolidFill, colours[i]);
		Bar(0, h3 * (i-1), GetMaxX, h3*i);
	end;
	
	readln();
end.
