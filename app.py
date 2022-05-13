# IMPORT REQUIRED LIBRARIES
from unicodedata import name
from urllib import response
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

from sqlalchemy import true

app = Flask(__name__)

db = SQLAlchemy(app)

app.config['SQLACLHEMY_TRACK_MODIFICATIONS']=False
app.config['SQLALCHEMY_DATABASE_URI']='mysql+pymysql://root:password@localhost:3308/student_manage'
# app.config['SQLALCHEMY_DATABASE_URI']='mysql+pymysql://root:divija123@localhost/student_manage'


# TODO : create Endpoint for get all teachers - 
#           it should return teacher ID and Teacher Name (ID is important)

# TODO : create a login for teachers - 
#           the current login only sees the students table and not the teachers table

# TODO : Do this in ALL APIs,
#           if the process (whatever it is) is successful return a dict {'message' : 'Success'} 'MAZZA AA GAYA' bhi chalega tbh
#           if the process is not successful then return {'message': 'Error (error description if possible'}


success_dict = {
    "message":"Success"
}

fail_dict = {
    "message":"Fail"
}

@app.route('/studentreg',methods=['POST'])
def registration():
    data=request.json
    name=data['name']
    email=data['email']
    phone=data['phone']
    password=data['password']
    svv_id=data['svv_id']
    year=data['year']
    dept_id=data['dept_id']
    try:
        db.engine.execute(f'insert into students_details(st_name,st_email,st_phone,st_pass,st_svv_id,st_year,dept_id) values("{name}","{email}",{phone},"{password}",{svv_id},"{year}",{dept_id});')
    except:
        return fail_dict
    return success_dict


@app.route('/login',methods=['POST'])
def login():
    data=request.json
    email=data['email']
    password=data['password']
    try:
        check=db.engine.execute(f'select st_id from students_details where st_email="{email}" and st_pass="{password}";')
    except :
        return fail_dict
    l=0
    for i in check:
        l+=1
        loggedin_id=i[0]
    if l>0:
        return {
            "message":"Success",
            "stu_id":str(loggedin_id)
            }
    else:
        return fail_dict

@app.route('/postQuestion',methods=['POST'])
def postQuestion():
    data = request.json
    question = data['question']
    stu_id = data['stu_id']
    topic = data['topic']
    date = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
    fac_id=data['faculty_id']
    try:
        db.engine.execute(f'insert into question(question,fac_id,stu_id,date,topic) VALUES ("{question}",{fac_id},{stu_id},"{date}","{topic}")')
    except:
        return fail_dict
    return success_dict


@app.route('/getAllQuestions',methods=['POST'])
def getAllQuestions():
    data = request.json
    stu_id = data['stu_id']
    try:
        result = db.engine.execute(f'select question.*, answer.answer_id,answer.answer from question LEFT OUTER JOIN answer on question.quest_id = answer.quest_id where stu_id = {stu_id};')
    except:
        return fail_dict
    response = {}
    i=1
    for each in result:
        response.update({f'{i}': dict(zip(result.keys(),each))})
        i+=1
    if response :
        response['isThere'] = "Yes"
    else :
        response['isThere'] = "No"
    response["message"] = "Success"
    return response

@app.route('/getAllQuestionsTeacher',methods=['POST'])
def getAllQuestionsTeacher():
    data = request.json
    fac_id = data['fac_id']
    try :
        result = db.engine.execute(f'select * from question where fac_id={fac_id} and status=false;')
    except:
        return fail_dict
    response = {}
    i=1
    for each in result:
        response.update({f'{i}': dict(zip(result.keys(),each))})
        i+=1
    if response :
        response['isThere'] = "Yes"
    else :
        response['isThere'] = "No"
    response['message'] = 'Success'
    return response

@app.route('/postAnswer',methods=['POST'])
def postAnswer():
    data = request.json
    quest_id=data['quest_id']
    answer = data['answer']
    try :
        db.engine.execute(f'insert into answer(quest_id,answer) values ({quest_id},"{answer}");')
        db.engine.execute(f'update question set status=true where quest_id={quest_id};')
    except:
        return fail_dict
    return success_dict

@app.route('/teacherLogin',methods=['POST'])
def teacherLogin():
    data=request.json
    email=data['email']
    password=data['password']
    try:
        check=db.engine.execute(f'select fac_id from faculty where fac_email="{email}" and fac_pass="{password}";')
    except:
        return fail_dict
    l=0
    response = {}
    for i in check:
        l+=1
        loggedin_id=i[0]
    if l>0:
        response["message"] = "Success"
        response["teach_id"] = str(loggedin_id)
        return response
    else:
        return fail_dict

@app.route('/getAllTeachers',methods=['POST'])
def getAllTeachers():
    data = request.json
    key = data['key']
    try:
        result = db.engine.execute(f'select fac_id, fac_name from faculty;')
    except:
        return fail_dict
    response = {}
    response['message'] = 'Success'
    i=1
    for each in result:
        response.update({f'{i}': dict(zip(result.keys(),each))})
        i+=1
    return response


if __name__ == '__main__':
    app.run()