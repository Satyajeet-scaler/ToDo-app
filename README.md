# ToDo App 📝

A full-featured task management application built with Ruby on Rails 8.1. This app allows users to create, read, update, and delete tasks with priority levels, status tracking, and time management capabilities.

## Features ✨

- **CRUD Operations**: Create, Read, Update, and Delete tasks
- **Task Status Management**: Track tasks as `ongoing`, `completed`, or `dropped`
- **Priority Levels**: Assign priority from 1 (highest) to 3 (lowest)
- **Time Tracking**: Set start and end times for tasks
- **Form Validations**: Ensures data integrity with model-level validations
- **Responsive Design**: Modern UI built with Hotwire (Turbo & Stimulus)
- **Flash Notifications**: User-friendly success/error messages

## Tech Stack 🛠️

- **Framework**: Ruby on Rails 8.1.1
- **Ruby Version**: Ruby 3.x (check `.ruby-version` or Gemfile)
- **Database**: SQLite3 (Development)
- **Frontend**: 
  - Turbo Rails (SPA-like experience)
  - Stimulus.js (JavaScript framework)
  - Importmap (ES6 modules)
- **CSS**: Application.css
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **WebSockets**: Solid Cable
- **Deployment**: Kamal (Docker-based deployment)

## Prerequisites 📋

Before you begin, ensure you have the following installed:
- **Ruby**: Version 3.x or higher
- **Rails**: Version 8.1.1
- **SQLite3**: Database engine
- **Node.js**: For JavaScript dependencies (optional but recommended)
- **Bundler**: Ruby dependency manager (`gem install bundler`)
- **Git**: Version control system

## Setup Instructions 🚀

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd ToDo-app
```

### Step 2: Install Ruby Dependencies
```bash
# Install all gems specified in Gemfile
bundle install
```

If you encounter any issues, try:
```bash
bundle update
bundle install
```

### Step 3: Database Setup
```bash
# Create the database
rails db:create

# Run migrations to create tables
rails db:migrate

# (Optional) Seed the database with sample data
rails db:seed
```

### Step 4: Start the Development Server
You have two options:

**Option A: Using bin/dev (Recommended)**
```bash
# This starts the Rails server with all necessary processes
bin/dev
```

**Option B: Using rails server**
```bash
# Start the server on default port 3000
rails server

# Or specify a different port
rails server -p 4000
```

### Step 5: Access the Application
Open your web browser and navigate to:
```
http://localhost:3000
```

You should see the ToDo app homepage!

### Troubleshooting Setup Issues

**Issue: Bundle install fails**
```bash
# Update RubyGems
gem update --system
# Update bundler
gem install bundler
# Try again
bundle install
```

**Issue: Database migration fails**
```bash
# Reset the database
rails db:drop db:create db:migrate
```

**Issue: Port 3000 is already in use**
```bash
# Find and kill the process using port 3000 (Linux/Mac)
lsof -ti:3000 | xargs kill -9

# Or use a different port
rails server -p 4000
```

## Screenshots & Demo 📸

### Application in Action

Below are screenshots demonstrating the key features of the ToDo app:

#### 1. Task List View (Index Page)
![Task List](https://github.com/Satyajeet-scaler/ToDo-app/blob/main/docs/screenshots/Task_list.png?raw=true)
*Overview of all tasks with their status, priority, and actions*

#### 2. Create New Task
![Create Task](https://github.com/Satyajeet-scaler/ToDo-app/blob/main/docs/screenshots/create_task.png?raw=true)
*Form to create a new task with all fields*

#### 3. Task Details View
![Task Details](https://github.com/Satyajeet-scaler/ToDo-app/blob/main/docs/screenshots/task_details.png?raw=true)
*Detailed view of a single task*

#### 4. Edit Task
![Edit Task](https://github.com/Satyajeet-scaler/ToDo-app/blob/main/docs/screenshots/edit_task.png?raw=true)
*Edit form with pre-filled task data*

#### 5. Delete Task 
![Delete Task](https://github.com/Satyajeet-scaler/ToDo-app/blob/main/docs/screenshots/delete_task.png?raw=true)
*Delete task window*


## Database Schema 📊

### Tasks Table
| Column | Type | Description |
|--------|------|-------------|
| id | integer | Primary key |
| title | string | Task title (required, max 200 chars) |
| description | string | Task description (optional) |
| status | string | Task status: ongoing/completed/dropped (default: ongoing) |
| start_time | datetime | When the task starts (optional) |
| end_time | datetime | When the task ends (optional) |
| priority | integer | Priority level 1-3 (default: 2) |

## Usage 💡

### Creating a Task
1. Click "New Task" button
2. Fill in the task details:
   - Title (required)
   - Description
   - Status (ongoing/completed/dropped)
   - Start and End time
   - Priority (1-3)
3. Click "Create Task"

### Editing a Task
1. Click "Edit" on any task
2. Update the desired fields
3. Click "Update Task"

### Deleting a Task
1. Click "Delete" on any task
2. Confirm the deletion

### Task Validations
- **Title**: Required, maximum 200 characters
- **Status**: Must be one of: ongoing, completed, dropped
- **Priority**: Must be an integer between 1 and 3

## Implementation Details 🏗️

### Architecture Overview

This ToDo application follows the **MVC (Model-View-Controller)** architectural pattern, a fundamental design pattern in Ruby on Rails that separates the application into three interconnected components.

```
┌─────────────────────────────────────────────────────────────────┐
│                         User Browser                             │
│                     (http://localhost:3000)                      │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            │ HTTP Request (GET /tasks)
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Rails Router                             │
│                      (config/routes.rb)                          │
│                   resources :tasks → Routes                      │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            │ Dispatches to Controller
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                     CONTROLLER LAYER                             │
│                  (app/controllers/)                              │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │           TasksController                                 │  │
│  │  - index    → List all tasks                             │  │
│  │  - show     → Display single task                        │  │
│  │  - new      → Render new task form                       │  │
│  │  - create   → Create new task                            │  │
│  │  - edit     → Render edit task form                      │  │
│  │  - update   → Update existing task                       │  │
│  │  - destroy  → Delete task                                │  │
│  └───────────────────────────────────────────────────────────┘  │
└───────────────┬──────────────────────────────┬──────────────────┘
                │                              │
                │ Queries/Commands             │ Renders
                ▼                              ▼
┌───────────────────────────────┐  ┌──────────────────────────────┐
│       MODEL LAYER             │  │       VIEW LAYER             │
│    (app/models/)              │  │    (app/views/tasks/)        │
│  ┌─────────────────────────┐  │  │  ┌────────────────────────┐  │
│  │     Task Model          │  │  │  │  index.html.erb        │  │
│  │  - Validations          │  │  │  │  show.html.erb         │  │
│  │  - Business Logic       │  │  │  │  new.html.erb          │  │
│  │  - Database Mapping     │  │  │  │  edit.html.erb         │  │
│  │                         │  │  │  │  _form.html.erb        │  │
│  │  Attributes:            │  │  │  └────────────────────────┘  │
│  │  - title                │  │  │                              │
│  │  - description          │  │  │  Helpers:                    │
│  │  - status               │  │  │  - Form builders             │
│  │  - start_time           │  │  │  - Flash messages            │
│  │  - end_time             │  │  │  - Link helpers              │
│  │  - priority             │  │  └──────────────────────────────┘
│  └─────────────────────────┘  │
│           │                   │
│           │ Active Record     │
│           ▼                   │
│  ┌─────────────────────────┐  │
│  │    SQLite Database      │  │
│  │    (Tasks Table)        │  │
│  └─────────────────────────┘  │
└───────────────────────────────┘
                │
                │ HTML Response
                ▼
┌─────────────────────────────────────────────────────────────────┐
│                         User Browser                             │
│                    (Rendered HTML Page)                          │
└─────────────────────────────────────────────────────────────────┘
```

### Request Flow Example

**Creating a New Task:**

1. **User Action**: User clicks "New Task" button
2. **Browser**: Sends `GET /tasks/new` request
3. **Router**: Matches route to `tasks#new`
4. **Controller**: `TasksController#new` creates empty Task object
5. **View**: Renders `new.html.erb` with form
6. **Browser**: Displays form to user
7. **User Action**: User fills form and submits
8. **Browser**: Sends `POST /tasks` with form data
9. **Router**: Matches route to `tasks#create`
10. **Controller**: `TasksController#create` receives params
11. **Model**: Task validates and saves to database
12. **Controller**: Redirects to task list with success message
13. **View**: Renders `index.html.erb` with all tasks
14. **Browser**: Displays updated task list

### Component Details

#### 1. **Model Layer** (`app/models/task.rb`)
**Responsibility**: Business logic and data validation

```ruby
- Validates presence of title
- Validates title length (max 200 chars)
- Validates status inclusion (ongoing, completed, dropped)
- Validates priority range (1-3)
- Handles database operations via Active Record
```

#### 2. **Controller Layer** (`app/controllers/tasks_controller.rb`)
**Responsibility**: Handle HTTP requests and coordinate between Model and View

```ruby
- RESTful actions (index, show, new, create, edit, update, destroy)
- Strong parameters for security
- before_action callbacks for DRY code
- Flash messages for user feedback
- Redirect logic after actions
```

#### 3. **View Layer** (`app/views/tasks/`)
**Responsibility**: Present data to users

```ruby
- ERB templates for dynamic HTML
- Partials for reusable components (_form.html.erb)
- Form helpers for user input
- Display flash messages
- Links for navigation
```

#### 4. **Routes** (`config/routes.rb`)
**Responsibility**: Map URLs to controller actions

```ruby
resources :tasks
# Generates:
# GET    /tasks          → index
# GET    /tasks/:id      → show
# GET    /tasks/new      → new
# POST   /tasks          → create
# GET    /tasks/:id/edit → edit
# PATCH  /tasks/:id      → update
# DELETE /tasks/:id      → destroy
```

### Database Schema

```
┌─────────────────────────────────────┐
│             Tasks Table              │
├──────────────┬──────────────────────┤
│ id           │ INTEGER (PK)         │
│ title        │ STRING (NOT NULL)    │
│ description  │ STRING (NULLABLE)    │
│ status       │ STRING (DEFAULT:     │
│              │   'ongoing')         │
│ start_time   │ DATETIME (NULLABLE)  │
│ end_time     │ DATETIME (NULLABLE)  │
│ priority     │ INTEGER (DEFAULT: 2) │
└──────────────┴──────────────────────┘
```

### Key Design Patterns Used

1. **MVC Pattern**: Separation of concerns across Model, View, Controller
2. **RESTful Architecture**: Standard HTTP methods for CRUD operations
3. **DRY Principle**: Form partial reused for new and edit actions
4. **Convention over Configuration**: Rails naming conventions
5. **Fat Model, Skinny Controller**: Business logic in models
6. **Strong Parameters**: Security pattern for mass assignment protection


## Project Structure 📁

```
ToDo-app/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   └── tasks_controller.rb      # All CRUD operations for tasks
│   ├── models/
│   │   ├── application_record.rb
│   │   └── task.rb                  # Task model with validations
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.erb # Main layout template
│   │   └── tasks/
│   │       ├── index.html.erb       # List all tasks
│   │       ├── show.html.erb        # Show single task
│   │       ├── new.html.erb         # New task form
│   │       ├── edit.html.erb        # Edit task form
│   │       └── _form.html.erb       # Shared form partial
│   ├── helpers/
│   │   ├── application_helper.rb
│   │   └── tasks_helper.rb
│   └── assets/
│       └── stylesheets/
│           └── application.css
├── config/
│   ├── routes.rb                    # URL routing configuration
│   ├── database.yml                 # Database configuration
│   ├── application.rb               # Application configuration
│   └── environments/
│       ├── development.rb
│       ├── production.rb
│       └── test.rb
├── db/
│   ├── migrate/
│   │   └── 20251211073002_create_tasks.rb  # Tasks table migration
│   ├── schema.rb                    # Current database schema
│   └── seeds.rb                     # Sample data for development
├── test/
│   ├── controllers/
│   │   └── tasks_controller_test.rb
│   ├── models/
│   │   └── task_test.rb
│   └── fixtures/
│       └── tasks.yml
├── Gemfile                          # Ruby dependencies
├── Rakefile                         # Rake tasks
├── Dockerfile                       # Container configuration
└── README.md                        # This file
```

