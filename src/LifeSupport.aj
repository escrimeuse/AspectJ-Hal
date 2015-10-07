
public aspect LifeSupport {
	
	
	declare precedence: LifeSupport, Authorization;
	
	// introductions for Crew class
	private boolean Crew.alive = true; 
	public int Crew.getLifeStatus() {
		if (this.alive == true) return 1;
		else return 0;
	}
	public String Crew.kill() {
		this.alive = false;
		return "You are being retired " + this;
	}
	
	// this pointcut captures messages with return type void sent by objects of static type Crew to objects of static type OnBoardComputer
	pointcut allVoidMessages(OnBoardComputer computer, Crew crew): call(void OnBoardComputer.*(..)) && target(computer) && this(crew) && !within(LifeSupport);
	
	// this pointcut captures messages with return type String sent by objects of static type Crew to objects of static type OnBoardComputer
	pointcut allStringMessages(OnBoardComputer computer, Crew crew): call(String OnBoardComputer.*(..)) && target(computer) && this(crew) && !within(LifeSupport) ;
	
	// this advice intercepts messages (with return type void) that are sent to objects of static type OnBoardComputer. It filters these messages so that
	// they are only executed if the crew member is alive. 
	void around(OnBoardComputer computer, Crew crew): allVoidMessages(computer,crew) {
		
		if (crew.getLifeStatus() == 1) {
			proceed(computer,crew);
		}
		else {
			// do nothing
		}
	}
	
	// this advice intercepts messages (with return type String) that are sent to objects of static type OnBoardComputer. It filters these messages so that
	// they are only executed if the crew member is alive.
	String around(OnBoardComputer computer, Crew crew): allStringMessages(computer,crew) {
		if (crew.getLifeStatus() == 1) {
			return proceed(computer,crew);
		}
		else return "";
	}
	
	

}
