[Skip to content](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982#main-content)
Navigation menu [ ![DEV Community](https://media2.dev.to/dynamic/image/quality=100/https://dev-to-uploads.s3.amazonaws.com/uploads/logos/resized_logo_UQww2soKuUsjaOGNB38o.png) ](https://dev.to/)
Search [ Powered by Algolia Search ](https://www.algolia.com/developers/?utm_source=devto&utm_medium=referral)
[ Log in ](https://dev.to/enter?signup_subforem=1) [ Create account ](https://dev.to/enter?signup_subforem=1&state=new-user)
## DEV Community
Close
![](https://assets.dev.to/assets/heart-plus-active-9ea3b22f2bc311281db911d416166c5f430636e76b15cd5df6b3b841d830eefa.svg) 38 Add reaction 
![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg) 33 Like  ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg) 1 Unicorn  ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg) 1 Exploding Head  ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg) 2 Raised Hands  ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg) 1 Fire 
0 Jump to Comments  6 Save  Boost 
More...
Copy link Copy link
Copied to Clipboard
[ Share to X ](https://twitter.com/intent/tweet?text=%22Understanding%20tasks%2C%20brokers%2C%20workers%2C%20and%20backends%20in%20Celery%22%20by%20%40tylerlwsmith%20%23DEVCommunity%20https%3A%2F%2Fdev.to%2Ftylerlwsmith%2Fdefining-tasks-brokers-workers-and-backends-in-celery-1982) [ Share to LinkedIn ](https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fdev.to%2Ftylerlwsmith%2Fdefining-tasks-brokers-workers-and-backends-in-celery-1982&title=Understanding%20tasks%2C%20brokers%2C%20workers%2C%20and%20backends%20in%20Celery&summary=Learn%20the%20high-level%20concepts%20in%20Celery%20so%20you%20can%20start%20building%20your%20own%20task%20queues.&source=DEV%20Community) [ Share to Facebook ](https://www.facebook.com/sharer.php?u=https%3A%2F%2Fdev.to%2Ftylerlwsmith%2Fdefining-tasks-brokers-workers-and-backends-in-celery-1982) [ Share to Mastodon ](https://s2f.kytta.dev/?text=https%3A%2F%2Fdev.to%2Ftylerlwsmith%2Fdefining-tasks-brokers-workers-and-backends-in-celery-1982)
[Share Post via...](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982) [Share Post via...](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982) [Report Abuse](https://dev.to/report-abuse)
[![Tyler Smith](https://media2.dev.to/dynamic/image/width=50,height=50,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F68031%2F18f40970-4f6b-403a-b5bd-3f469a206080.jpeg)](https://dev.to/tylerlwsmith)
[Tyler Smith](https://dev.to/tylerlwsmith)
Posted on Jul 23, 2024 • Edited on Jul 24, 2024
![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg) 33 ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg) 1 ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg) 1 ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg) 2 ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg) 1
#  Understanding tasks, brokers, workers, and backends in Celery 
[#python](https://dev.to/t/python) [#django](https://dev.to/t/django) [#celery](https://dev.to/t/celery)
Celery can be daunting to learn. While its documentation is comprehensive, it has a tendency to skip the basics.
This post will define four of the main concepts in Celery, discuss the relationship between Celery and [Kombu](https://docs.celeryq.dev/projects/kombu/en/v5.3.7/), and use a few code examples to illustrate how Celery might be useful in real applications. The examples will use the [Django web framework](https://www.djangoproject.com/) and its `@shared_task` decorator, but the concepts are also applicable to Flask, FastAPI, and others.
While the post contains code examples, it is not a tutorial. Read [First Steps with Celery](https://docs.celeryq.dev/en/stable/django/first-steps-with-django.html) from the official guide if you're completely new to Celery.
##  [ ](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982#tasks-brokers-workers-and-backends) Tasks, Brokers, Workers, and Backends 
You'll be hard pressed to find a place on the current Celery documentation that clearly spells out what it considers a **broker** or **backend** , but with enough digging you can find and infer definitions.
Below are concepts you should know before getting started with Celery.
###  [ ](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982#task) Task 
A **task** is some piece of work that Celery will perform _asynchronously_ (in this context, that's a fancy word for "not immediately"). In a web application, one task might be sending an email after a user submits a form. Sending an email can be a multi-second operation, and forcing a user to wait for an email to send before redirecting can make an application feel slow.
Tasks are defined using decorators in Celery. Below we use the `@shared_task` decorator to turn `send_thank_you_email()` into a Celery task that can be used in the `submit_feedback()` form submission handler.  


```
from config.celery import shared_task
from django.core.mail import send_mail
from django.shortcuts import render, redirect
from feedback.forms import FeedbackForm

@shared_task
def send_thank_you_email(email_address):
    send_mail(
        "Thank you for your feedback!",
        "We appreciate your input.",
        "noreply@example.com",
        [email_address],
    )

def submit_feedback(request):
    if request.method == "POST":
        form = FeedbackForm(request.POST)
        if form.is_valid():
            form.save()

            # Push the task to the broker using the delay() method.
            send_thank_you_email.delay(form.cleaned_data["email"])

            return redirect("/thank-you/")
    else:
        form = FeedbackForm()

    return render(request, "feedback.html", {"form": form})

```

Enter fullscreen mode Exit fullscreen mode
When a task is defined using a decorator in Celery, it adds a `delay()` method to the task. You can see the `send_thank_you_email` task calling the `delay()` method in the example above after the form is successfully saved. When `delay()` is called, it will send the `send_thank_you_email` task and its data to the **broker** where it is stored and will later be executed by a **worker** , at which point the user will be emailed.
The benefit of pushing work to Celery becomes more obvious if you need to send additional emails after saving the form. For example, you may want to email the customer support team that they have received new feedback. With Celery, this adds almost no additional time to the response. 
Celery tasks also allow additional advanced configuration. In the event an email failed to send, you can code your task to automatically retry and configure settings like `max_retries`, `retry_backoff`, `retry_jitter`, etc.
###  [ ](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982#broker) Broker 
The [Celery Enhancement Proposals' Glossary](https://docs.celeryq.dev/projects/celery-enhancement-proposals/en/latest/glossary.html?highlight=broker) has the following to say about **Message Brokers** :
> [Enterprise Integration Patterns](https://www.enterpriseintegrationpatterns.com/) defines a [Message Broker](https://www.enterpriseintegrationpatterns.com/patterns/messaging/MessageBroker.html) as an architectural building block that can receive [messages](https://docs.celeryq.dev/projects/celery-enhancement-proposals/en/latest/glossary.html?highlight=broker#term-Message) from multiple destinations, determine the correct destination and route the message to the correct channel.
For our purposes with Celery, we'll consider a **broker** a "message transport" where created tasks are stored. Brokers don't actually _execute_ the task: that is the job of a worker. Brokers are instead the place where scheduled tasks are _stored to_ when a task is scheduled, and _pulled from_ when a worker eventually executes a task. A broker is a _required_ component for Celery to work, and Celery will connect to exactly one broker.
Celery's [Backends and Brokers page](https://docs.celeryq.dev/en/v5.4.0/getting-started/backends-and-brokers/index.html) lists some if its supported brokers, and there are other experimental brokers it supports that are not listed (such as SQLAlchemy). These brokers (or "message transports") are managed by a Celery-maintained Python library for message transports called [Kombu](https://docs.celeryq.dev/projects/kombu/en/v5.3.7/introduction.html). When looking for information about configuring brokers, it is sometimes helpful to consult with Kombu's documentation rather that Celery's.
Some brokers have advanced features like task fanout and priority, while others operate as simple queues.
###  [ ](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982#worker) Worker 
A **worker** is an instance of Celery that pulls tasks from the broker and executes the task functions defined in your Python app. Celery is able to run Python code in its workers because Celery itself is written in Python.
Many workers can run simultaneously to execute tasks. When you run the `celery worker` command, it will spin up a worker for every core of your computer by default. If your computer has 16 cores, running `celery worker` will start 16 workers.
If no workers are running, messages (tasks) will accumulate in the broker until workers are available to execute them.
###  [ ](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982#backend) Backend 
The [tasks page](https://docs.celeryq.dev/en/v5.4.0/userguide/tasks.html#result-backends) in the Celery User Guide has the following to say about **backends** :
> If you want to keep track of tasks or need the return values, then Celery must store or send the states somewhere so that they can be retrieved later. There are several built-in result backends to choose from: SQLAlchemy/Django ORM, Memcached, RabbitMQ/QPid (rpc), and Redis – or you can define your own.
**TLDR:** a **backend** tracks the _outcomes_ and _returned results_ of async tasks. What does that actually mean, and when could it be useful?
Imagine you are building an accounting app in Django that can generate an annual report. The report could take minutes to generate.
To give your users a more responsive experience, you use an AJAX request to kick off a report generation task. That request returns an ID of the task, which it can use to poll the server every few seconds to see if the report is generated. Once the task is complete, it will return the ID of the report, which the client can use to display a link to the report via JavaScript.
We can implement this with Celery and Django using the following code:  


```
from celery import shared_task
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from accounting.models import Asset
from accounting.reports import AnnualReportGenerator

@shared_task
def generate_report_task(year):
    # This could take minutes...
    report = AnnualReportGenerator().generate(year)
    asset = Asset.objects.create(
        name=f"{year} annual report",
        url=report.url,
    )
    return asset.id

@require_http_methods(["POST"])
def generate_annual_report_view(request):
    year = request.POST.get("year")
    task = generate_report_task.delay(year)
    return JsonResponse({"taskId": task.id})

def get_annual_report_generation_status_view(request, task_id):
    task = generate_report_task.AsyncResult(task_id)

    # The status is typically "PENDING", "SUCCESS", or "FAILURE"
    status = task.status
    return JsonResponse({"status": status, "assetId": task.result})

```

Enter fullscreen mode Exit fullscreen mode
In this example, the asset ID returned by `generate_report_task()` is stored in a **backend**. The backend stores the _outcome_ and _returned result_. The backend does _not_ store the status of yet-to-be-processed tasks: these will only be added once there has been an outcome. A task that returns `"PENDING"` has a completely unknown status: an associated task might not even exist. Tasks will typically return `"SUCCESS"` or `"FAILURE"`, but you can see all statuses in the [Celery status docs](https://docs.celeryq.dev/en/v5.4.0/reference/celery.states.html#misc).
**Having a backend is not required for Celery to run tasks.** However, it is required if you ever need to check the outcome of a task or return a task's result. If you try to check a task's status when Celery does not have a backend configured, an exception will be raised.
* * *
I hope this post helps you understand the individual pieces of Celery and why you might consider using it. While the official documentation is challenging to grok, learning Celery deeply can unlock new possibilities within your Python applications.
##  Top comments (0)
Subscribe
![pic](https://media2.dev.to/dynamic/image/width=256,height=,fit=scale-down,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8j7kvp660rqzt99zui8e.png)
Personal Trusted User [ Create template ](https://dev.to/settings/response-templates)
Templates let you quickly answer FAQs or store snippets for re-use.
Submit Preview [Dismiss](https://dev.to/404.html)
[Code of Conduct](https://dev.to/code-of-conduct) • [Report abuse](https://dev.to/report-abuse)
Are you sure you want to hide this comment? It will become hidden in your post, but will still be visible via the comment's [permalink](https://dev.to/tylerlwsmith/defining-tasks-brokers-workers-and-backends-in-celery-1982). 
Hide child comments as well
Confirm 
For further actions, you may consider blocking this person and/or [reporting abuse](https://dev.to/report-abuse)
[ ![](https://media2.dev.to/dynamic/image/width=90,height=90,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.us-east-2.amazonaws.com%2Fuploads%2Fuser%2Fprofile_image%2F68031%2F18f40970-4f6b-403a-b5bd-3f469a206080.jpeg) Tyler Smith  ](https://dev.to/tylerlwsmith)
Follow
I'm a software developer who writes about Laravel, JavaScript, Rails, Linux, Docker, WordPress and the tech industry. Follow me on Twitter @tylerlwsmith 
  * Location 
Sacramento, California 
  * Education 
BA in Communications Emphasis in Public Relations 
  * Work 
Software Engineer 
  * Joined 
Apr 17, 2018


###  More from [Tyler Smith](https://dev.to/tylerlwsmith)
[ Get better autocomplete for Faker when using factory_boy  #python #testing ](https://dev.to/tylerlwsmith/get-better-autocomplete-for-faker-when-using-factoryboy-kki) [ Use SQLite as a Celery broker in Django  #django #celery #python #sqlite ](https://dev.to/tylerlwsmith/use-sqlite-as-a-celery-broker-in-django-1jne) [ Automatically reload Celery workers with a custom Django command  #django #celery #python ](https://dev.to/tylerlwsmith/automatically-reload-celery-workers-with-a-custom-django-command-1ojl)
💎 DEV Diamond Sponsors 
Thank you to our Diamond Sponsors for supporting the DEV Community 
[ ![Google AI - Official AI Model and Platform Partner](https://media2.dev.to/dynamic/image/width=880%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fxjlyhbdqehj3akhz166w.png) ](https://aistudio.google.com/?utm_source=partner&utm_medium=partner&utm_campaign=FY25-Global-DEVpartnership-sponsorship-AIS&utm_content=-&utm_term=-&bb=146443)
Google AI is the official AI Model and Platform Partner of DEV
[ ![Neon - Official Database Partner](https://media2.dev.to/dynamic/image/width=880%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fbnl88cil6afxzmgwrgtt.png) ](https://neon.tech/?ref=devto&bb=146443)
Neon is the official database partner of DEV
[ ![Algolia - Official Search Partner](https://media2.dev.to/dynamic/image/width=880%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fv30ephnolfvnlwgwm0yz.png) ](https://www.algolia.com/developers/?utm_source=devto&utm_medium=referral&bb=146443)
Algolia is the official search partner of DEV
[DEV Community](https://dev.to/) — A space to discuss and keep up software development and manage your software career 
  * [ Home ](https://dev.to/)
  * [ DEV Challenges ](https://dev.to/challenges)
  * [ DEV++ ](https://dev.to/++)
  * [ Videos ](https://dev.to/videos)
  * [ DEV Education Tracks ](https://dev.to/deved)
  * [ DEV Help ](https://dev.to/help)
  * [ Advertise on DEV ](https://dev.to/advertise)
  * [ Organization Accounts ](https://dev.to/organizations)
  * [ DEV Showcase ](https://dev.to/showcase)
  * [ About ](https://dev.to/about)
  * [ Contact ](https://dev.to/contact)
  * [ Free Postgres Database ](https://dev.to/free-postgres-database-tier)
  * [ DEV Shop ](https://shop.forem.com/)
  * [ MLH ](https://mlh.io/)


  * [ Code of Conduct ](https://dev.to/code-of-conduct)
  * [ Privacy Policy ](https://dev.to/privacy)
  * [ Terms of Use ](https://dev.to/terms)


Built on [Forem](https://www.forem.com) — the [open source](https://dev.to/t/opensource) software that powers [DEV](https://dev.to) and other inclusive communities.
Made with love and [Ruby on Rails](https://dev.to/t/rails). DEV Community © 2016 - 2026.
![DEV Community](https://media2.dev.to/dynamic/image/width=190,height=,fit=scale-down,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F8j7kvp660rqzt99zui8e.png)
We're a place where coders share, stay up-to-date and grow their careers. 
[ Log in ](https://dev.to/enter?signup_subforem=1) [ Create account ](https://dev.to/enter?signup_subforem=1&state=new-user)
![](https://assets.dev.to/assets/sparkle-heart-5f9bee3767e18deb1bb725290cb151c25234768a0e9a2bd39370c382d02920cf.svg) ![](https://assets.dev.to/assets/multi-unicorn-b44d6f8c23cdd00964192bedc38af3e82463978aa611b4365bd33a0f1f4f3e97.svg) ![](https://assets.dev.to/assets/exploding-head-daceb38d627e6ae9b730f36a1e390fca556a4289d5a41abb2c35068ad3e2c4b5.svg) ![](https://assets.dev.to/assets/raised-hands-74b2099fd66a39f2d7eed9305ee0f4553df0eb7b4f11b01b6b1b499973048fe5.svg) ![](https://assets.dev.to/assets/fire-f60e7a582391810302117f987b22a8ef04a2fe0df7e3258a5f49332df1cec71e.svg)

