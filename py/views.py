from models.user import User
from flask import request
from sqlalchemy import text

def init_app_routes(app, db):
    @app.route("/ping", methods=["GET"])
    def ping():
        return {"message": "pong"}
    
    @app.route("/health", methods=["GET"])
    def health_check():
        try:
            db.session.execute(text('SELECT 1')) # Attempt a simple database operation
            return {"database": "up", "status": "ready"}
        except Exception as e:
            app.logger.error(f"Readiness check failed: {e}")
            return {"database": "down", "status": "not ready"}

    @app.route("/users", methods=["POST"])
    def create_user():
        data = request.get_json()
        new_user = User(name=data["name"])
        db.session.add(new_user)
        db.session.commit()
        app.logger.info(f"Created User'{new_user.id}:{data['name']}'")
        return {"id": new_user.id}

    @app.route("/users", methods=["GET"])
    def get_users():
        all_users = User.query.all()
        users_list = []
        for user in all_users:
            user_dict = {"id": user.id, "name": user.name}
            users_list.append(user_dict)

        app.logger.info(f"Retrieved all users!")
        return {"users": users_list}

    @app.route("/users/<id>", methods=["GET"])
    def get_user(id):
        user = User.query.get(id)
        if user is None:
            app.logger.error(f"User {id} NOT FOUND")
            return {"error": "not found"}, 404
        app.logger.info(f"Retrieved User {id}")
        return {"data": user}

    @app.route("/users/<id>", methods=["PUT"])
    def update_user(id):
        data = request.get_json()
        user = User.query.get(id)
        if user is None:
            app.logger.error(f"User {id} NOT FOUND")
            return {"error": "not found"}, 404
        user.name = data["name"]
        db.session.commit()
        app.logger.info(f"Updated User '{id}:{data['name']}'")
        return {"success": True}

    @app.route("/users/<id>", methods=["DELETE"])
    def delete_user(id):
        user = User.query.get(id)
        if user is None:
            app.logger.error(f"User {id} NOT FOUND")
            return {"error": "not found"}, 404
        db.session.delete(user)
        db.session.commit()
        app.logger.info(f"Deleted User {id}")
        return {"success": True}
