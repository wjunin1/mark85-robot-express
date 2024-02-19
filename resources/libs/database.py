from robot.api.deco import  keyword
from pymongo import  MongoClient
import  bcrypt

client = MongoClient('mongodb+srv://wjunio23:qaexperience@cluster0.abbtduk.mongodb.net/?retryWrites=true&w=majority')

db = client['markdb']

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert user from database')
def insert_user(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }
    users = db['users']
    users.insert_one(user)
    print(user)