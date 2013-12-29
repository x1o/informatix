program BinaryTree;

uses
	Math,
	Graph;

const
	margin_x = 50;
	margin_y = margin_x;
	{ dy = 50; }
	{ dx = 25; }

var
	gd, gm, n, dx, dy: integer;
	parent: PointType;

procedure DrawLine(parent: PointType; cur_level, dx, dy: integer);
var
	left, right: PointType;
begin
	if cur_level = 0 then
		exit;

	left.x := parent.x - Round(dx * Power(2, cur_level-1));
	left.y := parent.y + dy;
	right.x := parent.x + Round(dx * Power(2, cur_level-1));
	right.y := left.y;
	
	Line(parent.x, parent.y, left.x, left.y);
	Line(parent.x, parent.y, right.x, right.y);

	DrawLine(left, cur_level - 1, dx, dy);
	DrawLine(right, cur_level - 1, dx, dy);
end;

begin
	write('Number of levels: ');
	readln(n);
	{ n := 3; }

	gd := detect;
	InitGraph(gd, gm, ''); 

	dx := Round((GetMaxX - 2 * margin_x) / ((Power(2, n) - 1) * 2));
	dy := Round((GetMaxY - 2 * margin_y) / n);
	parent.x := Round(GetMaxX / 2);
	parent.y := Round(GetMaxY / 2 - n * dy / 2);

	DrawLine(parent, n, dx, dy);

	readln();
	CloseGraph();
end.
