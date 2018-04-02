with text_io;
use text_io;

procedure sm_1 is

	protected semaphore is
		entry P;
		entry V;
	private
		level : integer := 5;
	end semaphore;

	protected body semaphore 
	is
		entry P when level > 0 is
		begin
			level := level - 1;
			put_line("level:" & level'img);
		end;

		entry V when level < 5 is
		begin
			level := level + 1;
			put_line("level:" & level'img);
		end;

	end semaphore;

	task type mytask;
	task body mytask is
	begin
		loop
			semaphore.P;
			delay 0.5;
			semaphore.V;
		end loop;
	end mytask;

	t1, t2, t3, t4, t5 : mytask;

begin
	null;
end sm_1;
