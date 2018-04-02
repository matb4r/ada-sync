with text_io;
use text_io;

procedure sm_n4 is

	protected Semafor is
		entry P(n : in integer);
		entry V(n : in integer);
	private
		entry PP(n : in integer);
		level : integer := 5;
		hold : boolean := false;
	end Semafor;

	protected body Semafor
	is
		entry P(n : in integer) when PP'count=0 is
		begin
			if level >= n then
				level := level - n;
				-- put_line("-" & n'img);
				-- put_line("level" & level'img);
			else
				hold := true;
				requeue PP;
			end if;
		end;

		entry PP(n : in integer) when not hold is
		begin
			requeue P;
		end;

		entry V(n : in integer) when true is
		begin
			level := level + n;
			-- put_line("+" & n'img);
			-- put_line("level" & level'img);
			hold := false;
		end;
	end Semafor;

	task t1;
	task body t1 is
	begin
		loop
			Semafor.P(1);
			put_line("1 in CS");
			delay 0.1;
			Semafor.V(1);
		end loop;
	end;

	task t2;
	task body t2 is
	begin
		loop
			Semafor.P(2);
			put_line("2 in CS");
			delay 0.1;
			Semafor.V(2);
		end loop;
	end;

	task t3;
	task body t3 is
	begin
		loop
			Semafor.P(3);
			put_line("3 in CS");
			delay 0.1;
			Semafor.V(3);
		end loop;
	end;

begin
	null;
end sm_n4;
