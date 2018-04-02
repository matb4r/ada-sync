with text_io;
use text_io;

procedure sm_n2 is

	protected Semaphore is
		entry P(n : in integer);
		entry V(n : in integer);
	private
		level : integer := 5;
		hold : boolean := false;
		entry P2(n : in integer);
	end Semaphore;

	protected body Semaphore 
	is
		entry P(n : in integer) when true is
		begin
			if level >= n then
				level := level - n;
				put_line("-" & n'img);
				put_line("level" & level'img);
			else
				hold := true;
				requeue P2;
			end if;
		end;

		entry P2(n : in integer) when not hold is
		begin
			requeue P;
		end;

		entry V(n : in integer) when true is
		begin
			level := level + n;
			put_line("+" & n'img);
			put_line("level" & level'img);
			hold := false;
		end;

	end Semaphore;

	task t2;
	task body t2 is
	begin
		loop
			Semaphore.P(2);
			delay 0.5;
			Semaphore.V(2);
			delay 0.5;
		end loop;
	end;

	task t3;
	task body t3 is
	begin
		loop
			Semaphore.P(3);
			delay 0.5;
			Semaphore.V(3);
			delay 0.5;
		end loop;
	end;

	task t4;
	task body t4 is
	begin
		loop
			Semaphore.P(4);
			delay 0.5;
			Semaphore.V(4);
			delay 0.5;
		end loop;
	end;

begin
	null;
end sm_n2;
