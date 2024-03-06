from flask import Flask
from views import init_app_routes
from extensions import db, migrate
import os

# Load the environment variables from the .env file

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
    "FLASK_DATABASE_URL", "sqlite:///test.db"
)

if __name__ == "__main__":

    db.init_app(app)
    migrate.init_app(app, db)
    
    with app.app_context():
        db.create_all()

    init_app_routes(app, db)
    app.run(debug=True, host='0.0.0.0')
