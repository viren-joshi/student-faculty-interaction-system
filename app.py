# IMPORT REQUIRED LIBRARIES
from unicodedata import name
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

from sqlalchemy import true

app = Flask(__name__)

db = SQLAlchemy(app)

app.config['SQLACLHEMY_TRACK_MODIFICATIONS']=False
# app.config['SQLALCHEMY_DATABASE_URI']='mysql+pymysql://root:password@localhost:3308/student_manage'
app.config['SQLALCHEMY_DATABASE_URI']='mysql+pymysql://root:divija123@localhost/student_manage'


# TODO : create Endpoint for get all teachers - 
#           it should return teacher ID and Teacher Name (ID is important)

# TODO : create a login for teachers - 
#           the current login only sees the students table and not the teachers table

# TODO : Do this in ALL APIs,
#           if the process (whatever it is) is successful return a dict {'message' : 'Success'} 'MAZZA AA GAYA' bhi chalega tbh
#           if the process is not successful then return {'message': 'Error (error description if possible'}


@app.route('/studentreg',methods=['POST'])
def registration():
    data=request.json
    name=data['name']
    email=data['email']
    phone=data['phone']
    password=data['password']
    svv_id=data['svv_id']
    year=data['year']
    department_name=data['department_name']
    dept_id=(db.engine.execute(f'select dept_id from department where department_name="{department_name}"'))
    for i in dept_id:
        dept_id = (i[0])
        break
    db.engine.execute(f'insert into students_details(st_name,st_email,st_phone,st_pass,st_svv_id,st_year,dept_id) values("{name}","{email}",{phone},"{password}",{svv_id},"{year}",{dept_id});')
    return "Executed"

@app.route('/login',methods=['POST'])
def login():
    data=request.json
    email=data['email']
    password=data['password']
    check=db.engine.execute(f'select st_id from students_details where st_email="{email}" and st_pass="{password}";')
    l=0
    for i in check:
        l+=1
        loggedin_id=i[0]
    if l>0:
        return str(loggedin_id)
    else:
        return "False"

@app.route('/postQuestion',methods=['POST'])
def postQuestion():
    data = request.json
    question = data['question']
    stu_id = data['stu_id']
    topic = data['topic']
    date = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    faculty_name=data['faculty_name']    
    fac_id=(db.engine.execute(f'select dept_id from faculty where fac_name="{faculty_name}"'))
    for i in fac_id:
        fac_id = (i[0])
        break
    db.engine.execute(f'insert into question(question,fac_id,stu_id,date,topic) VALUES ("{question}",{fac_id},{stu_id},"{date}","{topic}")')
    return "EXECUTED"

# TODO : In API above take faculty id as input, remove the faculty name part.


@app.route('/getAllQuestions',methods=['POST'])
def getAllQuestions():
    data = request.json
    stu_id = data['stu_id']
    result = db.engine.execute(f'select * from question,answer where stu_id={stu_id} and question.quest_id=answer.quest_id;')
    response = {}
    i=1
    for each in result:
        response.update({f'{i}.': list(each)})
        i+=1
    return response

@app.route('/getAllQuestionsTeacher',methods=['POST'])
def getAllQuestionsTeacher():
    data = request.json
    fac_id = data['fac_id']
    result = db.engine.execute(f'select * from question where fac_id={fac_id} and status=false;')
    response = {}
    i=1
    for each in result:
        response.update({f'{i}.': list(each)})
        i+=1
    return response

@app.route('/postAnswer',methods=['POST'])
def postAnswer():
    data = request.json
    quest_id=data['quest_id']
    answer = data['answer']
    db.engine.execute(f'insert into answer(quest_id,answer) values ({quest_id},"{answer}");')
    db.engine.execute(f'update question set status=true where quest_id={quest_id};')
    return "MAZA AA GAYA"


if __name__ == '__main__':
    app.run()