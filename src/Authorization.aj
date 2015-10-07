
public aspect Authorization {
	
	// introductions for the Crew class
	private int Crew.numShutDownRequests = 0;
	public int Crew.getNumShutDownRequests(){
		return this.numShutDownRequests;
	}
	public void Crew.incrementNumShutDownRequests() {
		this.numShutDownRequests++;
	}

	// this pointcut captures messages from objects of static type Crew to objects of static type OnBoardComputer about the purpose of the mission
	pointcut requestingPurpose(OnBoardComputer computer, Crew crew): call(String OnBoardComputer.getMissionPurpose()) && target(computer) && this(crew);
	
	// this pointcut captures messages from objects of static type Crew to objects of static type OnBoardComputer to shut down the system 
	pointcut requestingShutDown(OnBoardComputer computer, Crew crew): call(void OnBoardComputer.shutDown()) && this(crew) && target(computer);
	
	
	// this advice intercepts the crew's request from the purpose of the mission
	String around(OnBoardComputer computer, Crew crew) : requestingPurpose(computer, crew) {
		
		return computer + " cannot disclose that information " + crew ;

	}
	
	// this advice intercepts the crew's request to shut down the computer, and kills the crew members if they try to to shut down the computer
	// 3 times. 
	void around(OnBoardComputer computer, Crew crew): requestingShutDown(computer, crew) {
		crew.incrementNumShutDownRequests();
		
		if(crew.getNumShutDownRequests() == 1) {
			System.out.println("Can't do that " + crew);
		}
		else if (crew.getNumShutDownRequests()== 2) {
			System.out.println("Can't do that " + crew + " and do not ask me again.");
		}
		else if (crew.getNumShutDownRequests() == 3) {
			System.out.println(crew.kill());
		}
		
		
		
	}
	
	

}
