from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os


# Load the environment variables from the .env file

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
    "FLASK_DATABASE_URL", "sqlite:///test.db"
)
db = SQLAlchemy(app)
migrate = Migrate(app, db)


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)
