from models.user import User
from flask import request

def init_app_routes(app, db):
    @app.route("/ping", methods=["GET"])
    def ping():
        return {"message": "pong"}

    @app.route("/users", methods=["POST"])
    def create_user():
        data = request.get_json()
        new_user = User(name=data["name"])
        db.session.add(new_user)
        db.session.commit()
        return {"id": new_user.id}

    @app.route("/users", methods=["GET"])
    def get_users():
        all_users = User.query.all()
        return {"users": all_users}

    @app.route("/users/<id>", methods=["GET"])
    def get_user(id):
        user = User.query.get(id)
        if user is None:
            return {"error": "not found"}, 404
        return {"data": user}

    @app.route("/users/<id>", methods=["PUT"])
    def update_user(id):
        data = request.get_json()
        user = User.query.get(id)
        if user is None:
            return {"error": "not found"}, 404
        user.name = data["name"]
        db.session.commit()
        return {"success": True}

    @app.route("/users/<id>", methods=["DELETE"])
    def delete_user(id):
        user = User.query.get(id)
        if user is None:
            return {"error": "not found"}, 404
        db.session.delete(user)
        db.session.commit()
        return {"success": True}
