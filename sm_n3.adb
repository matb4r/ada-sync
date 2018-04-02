with text_io;
use text_io;

-- semafor uogolniony na obiekcie chronionym
procedure sm_n3 is
	
	protected Sem is
		entry P(n : in integer);
		entry V(n : in integer);
	private
		entry PP(n : in integer);
		level : integer := 5;
		hold : boolean := false;
	end;

	protected body Sem is
		entry P(n : in integer) when true is
		begin
			if level >= n then
				level := level - n;
				put_line("-" & n'img);
				put_line("level" & level'img);
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
			hold := false;
			put_line("+" & n'img);
			put_line("level" & level'img);
		end;
	end;

	task t2;
	task body t2 is
	begin
		loop
			Sem.P(2);
			delay 0.5;
			Sem.V(2);
			delay 0.5;
		end loop;
	end;

	task t3;
	task body t3 is
	begin
		loop
			Sem.P(3);
			delay 0.5;
			Sem.V(3);
			delay 0.5;
		end loop;
	end;

	task t4;
	task body t4 is
	begin
		loop
			Sem.P(4);
			delay 0.5;
			Sem.V(4);
			delay 0.5;
		end loop;
	end;

begin
	null;
end sm_n3;
