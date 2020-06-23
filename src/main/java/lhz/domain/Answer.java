package lhz.domain;

public class Answer {
    private String testname;
    private String sno;//学号
    private int grade;//分数
    private String myAnswer;
    private String myQuestion;

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getTestname() {
        return testname;
    }

    public void setTestname(String testname) {
        this.testname = testname;
    }

    public String getMyAnswer() {
        return myAnswer;
    }

    public void setMyAnswer(String myAnswer) {
        this.myAnswer = myAnswer;
    }

    public String getMyQuestion() {
        return myQuestion;
    }

    public void setMyQuestion(String myQuestion) {
        this.myQuestion = myQuestion;
    }


}
