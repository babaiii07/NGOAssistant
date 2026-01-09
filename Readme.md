# HelpSphere - NGO Chatbot Application

A modern, AI-powered chatbot application for NGOs built with Flask and Groq LLM. HelpSphere provides intelligent responses to user queries about NGO services, volunteering opportunities, donations, and more.

## Features

- 🤖 **AI-Powered Chatbot**: Uses Groq's fast LLM (Llama 3.1 70B) for intelligent, context-aware responses
- 💬 **Real-time Chat Interface**: Beautiful, responsive chat UI with typing indicators
- 🎨 **Modern UI**: Built with Tailwind CSS and Feather Icons
- 🐳 **Docker Ready**: Fully containerized for easy deployment
- 🔒 **Production Ready**: Includes WSGI server (Gunicorn) configuration
- 📝 **Context Awareness**: Maintains conversation history for better responses

## Tech Stack

- **Backend**: Flask (Python)
- **AI/LLM**: Groq API (Llama 3.1 70B)
- **Frontend**: HTML, JavaScript, Tailwind CSS
- **Deployment**: Docker, Gunicorn
- **Environment**: Python 3.11

## Prerequisites

- Python 3.11 or higher
- Docker (optional, for containerized deployment)
- Groq API Key ([Get one here](https://console.groq.com/))

## Installation

### Local Development

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd NGOAssistant
   ```

2. **Create a virtual environment**
   ```bash
   python -m venv venv
   
   # On Windows
   venv\Scripts\activate
   
   # On Linux/Mac
   source venv/bin/activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   GROQ_API_KEY=your_groq_api_key_here
   FLASK_ENV=development
   PORT=5000
   ```

5. **Run the application**
   ```bash
   python app.py
   ```

   The application will be available at `http://localhost:5000`

### Docker Deployment

1. **Build the Docker image**
   ```bash
   docker build -t helpsphere-chatbot .
   ```

2. **Run the container**
   ```bash
   docker run -d \
     -p 5000:5000 \
     -e GROQ_API_KEY=your_groq_api_key_here \
     --name helpsphere \
     helpsphere-chatbot
   ```

   Or use Docker Compose (create `docker-compose.yml`):
   ```yaml
   version: '3.8'
   services:
     app:
       build: .
       ports:
         - "5000:5000"
       environment:
         - GROQ_API_KEY=${GROQ_API_KEY}
       restart: unless-stopped
   ```

   Then run:
   ```bash
   docker-compose up -d
   ```

## Project Structure

```
NGOAssistant/
├── app.py                 # Main Flask application
├── wsgi.py                # WSGI entry point for production
├── requirements.txt       # Python dependencies
├── Dockerfile             # Docker configuration
├── .env                   # Environment variables (create this)
├── Readme.md              # This file
└── templates/
    └── index.html         # Frontend HTML template
```

## API Endpoints

### `GET /`
Renders the main chatbot interface.

### `POST /api/chat`
Sends a message to the chatbot and receives an AI-generated response.

**Request Body:**
```json
{
  "message": "How can I volunteer?",
  "history": [
    {"role": "user", "content": "Hello"},
    {"role": "assistant", "content": "Hello! How can I help you?"}
  ]
}
```

**Response:**
```json
{
  "response": "We're always looking for passionate volunteers!...",
  "status": "success"
}
```

### `GET /api/health`
Health check endpoint.

**Response:**
```json
{
  "status": "healthy",
  "groq_configured": true
}
```

## Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `GROQ_API_KEY` | Your Groq API key | Yes | - |
| `FLASK_ENV` | Flask environment (development/production) | No | - |
| `PORT` | Port to run the application | No | 5000 |

## Deployment

### Production Deployment with Gunicorn

```bash
gunicorn --bind 0.0.0.0:5000 --workers 4 --threads 2 --timeout 120 wsgi:app
```

### Cloud Platforms

#### Heroku
1. Create a `Procfile`:
   ```
   web: gunicorn --bind 0.0.0.0:$PORT --workers 4 wsgi:app
   ```

2. Set environment variables in Heroku dashboard:
   ```
   GROQ_API_KEY=your_key_here
   ```

3. Deploy:
   ```bash
   git push heroku main
   ```

#### Railway/Render/Fly.io
- Use the Dockerfile provided
- Set `GROQ_API_KEY` as an environment variable
- Deploy using their respective platforms

## Configuration

### Customizing the System Prompt

Edit the `SYSTEM_PROMPT` variable in `app.py` to customize the chatbot's behavior, knowledge base, and tone.

### Adjusting AI Parameters

In `app.py`, modify the Groq API call parameters:
- `temperature`: Controls randomness (0.0-1.0)
- `max_tokens`: Maximum response length
- `model`: Change to a different Groq model if needed

## Troubleshooting

### API Key Issues
- Ensure `GROQ_API_KEY` is set correctly in your `.env` file
- Check that the API key is valid and has sufficient credits

### Port Already in Use
- Change the `PORT` environment variable
- Or kill the process using the port:
  ```bash
  # Linux/Mac
  lsof -ti:5000 | xargs kill
  
  # Windows
  netstat -ano | findstr :5000
  taskkill /PID <PID> /F
  ```

### Docker Issues
- Ensure Docker is running
- Check logs: `docker logs helpsphere`
- Verify environment variables are set correctly

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the MIT License.

## Support

For issues, questions, or contributions, please open an issue on the repository.

## Acknowledgments

- [Groq](https://groq.com/) for the fast LLM API
- [Flask](https://flask.palletsprojects.com/) for the web framework
- [Tailwind CSS](https://tailwindcss.com/) for styling

