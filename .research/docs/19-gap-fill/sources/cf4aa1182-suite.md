[Skip to main content](https://temporal.io/comms#main-content)

sessionId: 1781566264673

userId:

deviceId: 9e39dea9-8a5c-43ec-80b1-de0685ff5ca3

UpdateResetUpdate User IDUpdate Device ID

[Skip to main content](https://docs.temporal.io/develop/go/best-practices/testing-suite#__docusaurus_skipToContent_fallback)

[![Temporal logo](https://docs.temporal.io/img/assets/temporal-logo-dark.svg)](https://temporal.io/)[Home](https://docs.temporal.io/) [Courses](https://learn.temporal.io/getting_started/) [SDKs](https://docs.temporal.io/develop) [AI Cookbook](https://docs.temporal.io/ai-cookbook) [Code Exchange](https://temporal.io/code-exchange) [Temporal Cloud](https://docs.temporal.io/cloud)

Ask AI

Search`Ctrl`  `K`

- [Home](https://docs.temporal.io/)
- [Quickstarts](https://docs.temporal.io/quickstarts)
- [Evaluate](https://docs.temporal.io/evaluate/)

- [Develop](https://docs.temporal.io/develop/)

  - [Go SDK](https://docs.temporal.io/develop/go/)

    - [Quickstart](https://docs.temporal.io/develop/go/set-up-your-local-go)
    - [Workflows](https://docs.temporal.io/develop/go/workflows/)

    - [Activities](https://docs.temporal.io/develop/go/activities/)

    - [Workers](https://docs.temporal.io/develop/go/workers/)

    - [Client](https://docs.temporal.io/develop/go/client/)

    - [Temporal Nexus](https://docs.temporal.io/develop/go/nexus/)

    - [Platform](https://docs.temporal.io/develop/go/platform/)

    - [Best practices](https://docs.temporal.io/develop/go/best-practices/)

      - [Multithreading](https://docs.temporal.io/develop/go/best-practices/multithreading)
      - [Context Propagation](https://docs.temporal.io/develop/go/best-practices/context-propagation)
      - [Error handling](https://docs.temporal.io/develop/go/best-practices/error-handling)
      - [Debugging](https://docs.temporal.io/develop/go/best-practices/debugging)
      - [Testing](https://docs.temporal.io/develop/go/best-practices/testing-suite)
      - [Data handling](https://docs.temporal.io/develop/go/data-handling)
  - [Java SDK](https://docs.temporal.io/develop/java/)

  - [PHP SDK](https://docs.temporal.io/develop/php/)

  - [Python SDK](https://docs.temporal.io/develop/python/)

  - [TypeScript SDK](https://docs.temporal.io/develop/typescript/)

  - [.NET SDK](https://docs.temporal.io/develop/dotnet/)

  - [Ruby SDK](https://docs.temporal.io/develop/ruby/)

  - [Rust SDK](https://docs.temporal.io/develop/rust/)

  - [Environment configuration](https://docs.temporal.io/develop/environment-configuration)
  - [Activity retry simulator](https://docs.temporal.io/develop/activity-retry-simulator)
  - [Worker performance](https://docs.temporal.io/develop/worker-performance)
  - [Worker tuning reference](https://docs.temporal.io/develop/worker-tuning-reference)
  - [Safe deployments](https://docs.temporal.io/develop/safe-deployments)
  - [Plugins guide](https://docs.temporal.io/develop/plugins-guide)
  - [Task queue priority and fairness](https://docs.temporal.io/develop/task-queue-priority-fairness)
- [Temporal Cloud](https://docs.temporal.io/cloud)

- [Deploy to production](https://docs.temporal.io/production-deployment)

- [CLI (temporal)](https://docs.temporal.io/cli)

- [References](https://docs.temporal.io/references/)

- [Troubleshooting](https://docs.temporal.io/troubleshooting/)

- [Best practices](https://docs.temporal.io/best-practices/)

- [Encyclopedia](https://docs.temporal.io/encyclopedia/)

- [Interactive Demos](https://docs.temporal.io/develop/go/best-practices/testing-suite#)

- [Integrations](https://docs.temporal.io/integrations)
- [Glossary](https://docs.temporal.io/glossary)
- [Develop with AI](https://docs.temporal.io/with-ai)

- [Home page](https://docs.temporal.io/)
- [Develop](https://docs.temporal.io/develop/)
- [Go SDK](https://docs.temporal.io/develop/go/)
- [Best practices](https://docs.temporal.io/develop/go/best-practices/)
- Testing

On this page

# Testing - Go SDK

Copy

The Testing section of the Temporal Application development guide describes the frameworks that facilitate Workflow and integration testing.

In the context of Temporal, you can create these types of automated tests:

- **End-to-end:** Running a Temporal Server and Worker with all its Workflows and Activities; starting and interacting with Workflows from a Client.
- **Integration:**Anything between end-to-end and unit testing.
  - Running Activities with mocked Context and other SDK imports (and usually network requests).
  - Running Workers with mock Activities, and using a Client to start Workflows.
  - Running Workflows with mocked SDK imports.
- **Unit:** Running a piece of Workflow or Activity code (a function or method) and mocking any code it calls.

We generally recommend writing the majority of your tests as integration tests.

Because the test server supports skipping time, use the test server for both end-to-end and integration tests with Workers.

## Test frameworks [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#test-frameworks "Direct link to Test frameworks")

The Temporal Go SDK provides a test framework to facilitate testing Workflow implementations.

This framework is suited for implementing unit tests as well as functional tests of the Workflow logic.

## Test setup [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#test-setup "Direct link to Test setup")

To run unit tests, we first define a test suite struct that absorbs both the basic suite functionality from [testify](https://pkg.go.dev/github.com/stretchr/testify/suite) via `suite.Suite` and the suite functionality from the Temporal test framework via `testsuite.WorkflowTestSuite`.

Because every test in this test suite will test our Workflow, we
add a property to our struct to hold an instance of the test environment. This allows us to initialize the test environment in a setup method.

For testing Workflows, we use a `testsuite.TestWorkflowEnvironment`.

```go
type UnitTestSuite struct {

        suite.Suite

        testsuite.WorkflowTestSuite

        env *testsuite.TestWorkflowEnvironment

}
```

Next, we implement a `SetupTest` method to set up a new test environment before each test.
Doing so ensures that each test runs in its own isolated sandbox.

```go
func (s *UnitTestSuite) SetupTest() {

        s.env = s.NewTestWorkflowEnvironment()

}
```

We also implement an `AfterTest` function where we assert that all the mocks we set up were indeed called by invoking `s.env.AssertExpectations(s.T())`.
Timeout for the entire test can be set using `SetTestTimeout` in the Workflow or Activity environment.

```go
func (s *UnitTestSuite) AfterTest(suiteName, testName string) {

        s.env.AssertExpectations(s.T())

}
```

Finally, we create a regular test function recognized by the `go test` command, and pass the struct to `suite.Run`.

```go
func TestUnitTestSuite(t *testing.T) {

        suite.Run(t, new(UnitTestSuite))

}
```

## Testing Activities [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#test-activities "Direct link to Testing Activities")

An Activity can be tested with a mock Activity environment, which provides a way to mock the Activity context, listen to Heartbeats, and cancel the Activity.
This behavior allows you to test the Activity in isolation by calling it directly, without needing to create a Worker to run the Activity.

## Mock and override Activities [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#mock-and-override-activities "Direct link to Mock and override Activities")

When running unit tests on Workflows, we want to test the Workflow logic in isolation. Additionally, we want to inject Activity errors during our test runs. The test framework provides two mechanisms that support these scenarios: Activity mocking and Activity overriding. Both of these mechanisms allow you to change the behavior of Activities invoked by your Workflow without the need to modify the actual Workflow code.

Let's take a look at a test that simulates a test that fails via the "Activity mocking" mechanism.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_ActivityFails() {

        s.env.OnActivity(SimpleActivity, mock.Anything, mock.Anything).Return(

          "", errors.New("SimpleActivityFailure"))

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_failure")

        s.True(s.env.IsWorkflowCompleted())

        err := s.env.GetWorkflowError()

        s.Error(err)

        var applicationErr *temporal.ApplicationError

        s.True(errors.As(err, &applicationErr))

        s.Equal("SimpleActivityFailure", applicationErr.Error())

}
```

This test simulates the execution of the Activity `SimpleActivity` that is invoked by our Workflow `SimpleWorkflow` returning an error. We accomplish this by setting up a mock on the test environment for the `SimpleActivity` that returns an error.

```go
s.env.OnActivity(SimpleActivity, mock.Anything, mock.Anything).Return(

  "", errors.New("SimpleActivityFailure"))
```

With the mock set up we can now execute the Workflow via the `s.env.ExecuteWorkflow(...)` method and assert that the Workflow completed successfully and returned the expected error.

Simply mocking the execution to return a desired value or error is a pretty powerful mechanism to isolate Workflow logic.
However, sometimes we want to replace the Activity with an alternate implementation to support a more complex test scenario.
Let's assume we want to validate that the Activity gets called with the correct parameters.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_ActivityParamCorrect() {

        s.env.OnActivity(SimpleActivity, mock.Anything, mock.Anything).Return(

          func(ctx context.Context, value string) (string, error) {

                s.Equal("test_success", value)

                return value, nil

        })

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_success")

        s.True(s.env.IsWorkflowCompleted())

        s.NoError(s.env.GetWorkflowError())

}
```

In this example, we provide a function implementation as the parameter to `Return`.
This allows us to provide an alternate implementation for the Activity `SimpleActivity`.
The framework will execute this function whenever the Activity is invoked and pass on the return value from the function as the result of the Activity invocation.

Additionally, the framework will validate that the signature of the "mock" function matches the signature of the original Activity function.

Since this can be an entire function, there is no limitation as to what we can do here. In this example, we assert that the `value` param has the same content as the value param we passed to the Workflow.

### Run an Activity [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#run-an-activity "Direct link to Run an Activity")

If an Activity references its context, you need to mock that context when testing in isolation.

### Listen to Heartbeats [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#listen-to-heartbeats "Direct link to Listen to Heartbeats")

When an Activity sends a Heartbeat, be sure that you can see the Heartbeats in your test code so that you can verify them.

### Cancel an Activity [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#cancel-an-activity "Direct link to Cancel an Activity")

If an Activity is supposed to react to a Cancellation, you can test whether it reacts correctly by canceling it.

## Mock and override Nexus operations [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#mock-and-override-nexus-operations "Direct link to Mock and override Nexus operations")

Mocking Nexus operations lets you test a Workflow that executes Nexus operations without needing a
Nexus handler to run the actual Nexus operation. You can mock the Nexus operation or override its
implementation with the test Workflow environment.

Consider a test that simulates a Nexus operation call. In this example, the Nexus operation is
called `sample-operation`, the input type is `SampleInput`, the output type is `SampleOutput`, and
it belongs to the Nexus service `sample-service`.

The example below mocks a call to a Nexus synchronous operation, indicated by the returned value
type `*nexus.HandlerStartOperationResultSync[T]`. Since `OnNexusOperation` needs to know the
operation's name, input type and output type, and you might not have access to the Nexus operation
on the handler side, you can use `nexus.NewOperationReference` to create a Nexus operation reference
that represents the operation without its implementation (basically, it represents the signature of
the Nexus operation). You may also use the operation itself instead of creating the operation
reference if you have it available.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_NexusSyncOperation() {

        s.env.OnNexusOperation(

                "sample-service",

                nexus.NewOperationReference[SampleInput, SampleOutput]("sample-operation"),

                SampleInput{},

                workflow.NexusOperationOptions{},

        ).Return(

                &nexus.HandlerStartOperationResultSync[SampleOutput]{

                        Value: SampleOutput{},

                },

                nil, // error if you want to simulate an error in the ExecuteOperation call

        )

        // You can also add a delay to return the mock values by calling After().

        // Eg: s.env.OnNexusOperation(...).Return(...).After(1*time.Second)

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_nexus_operation")

        s.True(s.env.IsWorkflowCompleted())

        s.NoError(s.env.GetWorkflowError())

}
```

Besides the synchronous operations, you can also mock asynchronous operations. The following example
demonstrates how to test a Workflow executing a Nexus asynchronous operation. The returned value
type in this case must be `*nexus.HandlerStartOperationResultAsync` with an `OperationToken`, which can
be any string of your choice. Furthermore, you must call `RegisterNexusAsyncOperationCompletion` to
register the result of the asynchronous operation identified by the tuple service name, operation
name, and operation token.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_NexusAsyncOperation() {

        s.env.OnNexusOperation(

                "sample-service",

                nexus.NewOperationReference[SampleInput, SampleOutput]("sample-operation"),

                SampleInput{},

                workflow.NexusOperationOptions{},

        ).Return(

                &nexus.HandlerStartOperationResultAsync{

                        OperationToken: "sample-operation-token",

                },

                nil, // error if you want to simulate an error in the ExecuteOperation call

        )

        err := env.RegisterNexusAsyncOperationCompletion(

                "sample-service",

                "sample-operation",

                "sample-operation-token", // must match the OperationToken above

                SampleOutput{},

                nil,            // error if you want to simulate an error in the operation

                2*time.Second,  // delay to simulate how long the operation takes after it starts

        )

        s.NoError(err)

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_nexus_operation")

        s.True(s.env.IsWorkflowCompleted())

        s.NoError(s.env.GetWorkflowError())

}
```

If your Workflow executes multiple Nexus asynchronous operations, you can mock each of them with
different operation tokens, and register the completion results using the corresponding operation token.

If mocking Nexus operations is not enough, and you need to run some custom logic when the Nexus
operation is executed, you can override it as follows.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_NexusSyncOperation() {

        var SampleOperation = nexus.NewSyncOperation(

                "sample-operation",

                func(ctx context.Context, input SampleInput, options nexus.StartOperationOptions) (SampleOutput, error) {

                        // Custom logic here.

                        return SampleOutput{}, nil

                },

        )

        service := nexus.NewService("sample-service")

        s.NoError(service.Register(SampleOperation))

        env.RegisterNexusService(service)

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_nexus_operation")

        s.True(s.env.IsWorkflowCompleted())

        s.NoError(s.env.GetWorkflowError())

}
```

The following example shows how to override a Nexus asynchronous operation.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_NexusSyncOperation() {

        SampleHandlerWorkflow := func(_ workflow.Context, input SampleInput) (SampleOutput, error) {

                // Custom logic here.

                return SampleOutput{}, nil

        }

        SampleOperation := nexus.NewWorkflowRunOperation(

                "sample-operation",

                SampleHandlerWorkflow,

                func(ctx context.Context, input SampleInput, options nexus.StartOperationOptions) (client.StartWorkflowOptions, error) {

                        // Custom logic to build client.StartWorkflowOptions.

                        return client.StartWorkflowOptions{}, nil

                },

        )

        service := nexus.NewService("sample-service")

        s.NoError(service.Register(SampleOperation))

        env.RegisterNexusService(service)

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_nexus_operation")

        s.True(s.env.IsWorkflowCompleted())

        s.NoError(s.env.GetWorkflowError())

}
```

## Testing Workflows [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#test-workflows "Direct link to Testing Workflows")

When running unit tests on Workflows, we want to test the Workflow logic in isolation.
The simplest test case we can write is to have the test environment execute the Workflow and then evaluate the results.

```go
func (s *UnitTestSuite) Test_SimpleWorkflow_Success() {

        s.env.ExecuteWorkflow(SimpleWorkflow, "test_success")

        s.True(s.env.IsWorkflowCompleted())

        s.NoError(s.env.GetWorkflowError())

}
```

Calling `s.env.ExecuteWorkflow(...)` executes the Workflow logic and any invoked Activities inside the test process. The first parameter of `s.env.ExecuteWorkflow(...)` contains the Workflow functions, and any subsequent parameters contain values for custom input parameters declared by the Workflow.

> Note that unless the Activity invocations are mocked or Activity implementation replaced (see [Activity mocking and overriding](https://docs.temporal.io/develop/go/best-practices/testing-suite#mock-and-override-activities)), the test environment will execute the actual Activity code including any calls to outside services.

After executing the Workflow in the above example, we assert that the Workflow ran through completion via the call to `s.env.IsWorkflowCompleted()`. We also assert that no errors were returned by asserting on the return value of `s.env.GetWorkflowError()`.
If our Workflow returned a value, we could have retrieved that value via a call to `s.env.GetWorkflowResult(&value)` and had additional asserts on that value.

### Query tests [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#query-tests "Direct link to Query tests")

`TestWorkflowEnvironment` instances have a [`QueryWorkflow()` method](https://pkg.go.dev/go.temporal.io/temporal/internal#TestWorkflowEnvironment.QueryWorkflow) that lets you query the state of the currently running Workflow.
For example, suppose you have a Workflow that lets you query the progress of a long running task as shown below.

```go
func ProgressWorkflow(ctx workflow.Context, percent int) error {

	logger := workflow.GetLogger(ctx)

	err := workflow.SetQueryHandler(ctx, "getProgress", func(input []byte) (int, error) {

		return percent, nil

	})

	if err != nil {

		logger.Info("SetQueryHandler failed.", "Error", err)

		return err

	}

	for percent = 0; percent<100; percent++ {

                // Important! Use `workflow.Sleep()`, not `time.Sleep()`, because Temporal's

                // test environment doesn't stub out `time.Sleep()`.

		workflow.Sleep(ctx, time.Second*1)

	}

	return nil

}
```

This Workflow tracks the current progress of a task in percentage terms, and increments the percentage by 1 every second.
Below is how you would write a test case that queries this Workflow.
Note that you should always query the Workflow either after `ExecuteWorkflow()` is done or in a `RegisterDelayedCallback()` callback, otherwise you'll get a `runtime error` panic.

```go
func (s *UnitTestSuite) Test_ProgressWorkflow() {

	value := 0

	// After 10 seconds plus padding, progress should be 10.

	// Note that `RegisterDelayedCallback()` doesn't actually make your test wait for 10 seconds!

	// Temporal's test framework advances time internally, so this test should take < 1 second.

	s.env.RegisterDelayedCallback(func() {

		res, err := s.env.QueryWorkflow("getProgress")

		s.NoError(err)

		err = res.Get(&value)

		s.NoError(err)

		s.Equal(10, value)

	}, time.Second*10+time.Millisecond*1)

	s.env.ExecuteWorkflow(ProgressWorkflow, 0)

	s.True(s.env.IsWorkflowCompleted())

	// Once the workflow is completed, progress should always be 100

	res, err := s.env.QueryWorkflow("getProgress")

	s.NoError(err)

	err = res.Get(&value)

	s.NoError(err)

	s.Equal(value, 100)

}
```

info

`RegisterDelayedCallback` can also be used to send [Signals](https://docs.temporal.io/sending-messages#sending-signals).
When using "Signal-With-Start", set the delay to `0`.

### How to mock Activities [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#mock-activities "Direct link to How to mock Activities")

Mock the Activity invocation when unit testing your Workflows.

When integration testing Workflows with a Worker, you can mock Activities by providing mock Activity implementations to the Worker.

### How to skip time [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#skip-time "Direct link to How to skip time")

Some long-running Workflows can persist for months or even years.
Implementing the test framework allows your Workflow code to skip time and complete your tests in seconds rather than the Workflow's specified amount.

For example, if you have a Workflow sleep for a day, or have an Activity failure with a long retry interval, you don't need to wait the entire length of the sleep period to test whether the sleep function works.
Instead, test the logic that happens after the sleep by skipping forward in time and complete your tests in a timely manner.

The test framework included in most SDKs is an in-memory implementation of Temporal Server that supports skipping time.
Time is a global property of an instance of `TestWorkflowEnvironment`: skipping time (either automatically or manually) applies to all currently running tests.
If you need different time behaviors for different tests, run your tests in a series or with separate instances of the test server.
For example, you could run all tests with automatic time skipping in parallel, and then all tests with manual time skipping in series, and then all tests without time skipping in parallel.

#### Set up time skipping [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#setting-up "Direct link to Set up time skipping")

Set up the time-skipping test framework in the SDK of your choice.

\*/}

You can skip time automatically in the SDK of your choice.
Start a test server process that skips time as needed.
For example, in the time-skipping mode, Timers, which include sleeps and conditional timeouts, are fast-forwarded except when Activities are running.

\*/}

Skip time manually in the SDK of your choice.

#### Skip time in Activities [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#skip-time-in-activities "Direct link to Skip time in Activities")

Skip time in Activities in the SDK of your choice.

## How to Replay a Workflow Execution [​](https://docs.temporal.io/develop/go/best-practices/testing-suite\#replay "Direct link to How to Replay a Workflow Execution")

Replay recreates the exact state of a Workflow Execution.
You can replay a Workflow from the beginning of its Event History.

Replay succeeds only if the [Workflow Definition](https://docs.temporal.io/workflow-definition) is compatible with the provided history from a deterministic point of view.

When you test changes to your Workflow Definitions, we recommend doing the following as part of your CI checks:

1. Determine which Workflow Types or Task Queues (or both) will be targeted by the Worker code under test.
2. Download the Event Histories of a representative set of recent open and closed Workflows from each Task Queue, either programmatically using the SDK client or via the Temporal CLI.
3. Run the Event Histories through replay.
4. Fail CI if any error is encountered during replay.

The following are examples of fetching and replaying Event Histories:

Use the [worker.WorkflowReplayer](https://pkg.go.dev/go.temporal.io/sdk/worker#WorkflowReplayer) to replay an existing Workflow Execution from its Event History to replicate errors.

For example, the following code retrieves the Event History of a Workflow:

```go
import (

	"context"

	"go.temporal.io/api/enums/v1"

	"go.temporal.io/api/history/v1"

	"go.temporal.io/sdk/client"

)

func GetWorkflowHistory(ctx context.Context, client client.Client, id, runID string) (*history.History, error) {

	var hist history.History

	iter := client.GetWorkflowHistory(ctx, id, runID, false, enums.HISTORY_EVENT_FILTER_TYPE_ALL_EVENT)

	for iter.HasNext() {

		event, err := iter.Next()

		if err != nil {

			return nil, err

		}

		hist.Events = append(hist.Events, event)

	}

	return &hist, nil

}
```

This history can then be used to _replay_.
For example, the following code creates a `WorkflowReplayer` and register the `YourWorkflow` Workflow function.
Then it calls the `ReplayWorkflowHistory` to _replay_ the Event History and return an error code.

```go
import (

	"context"

	"go.temporal.io/sdk/client"

	"go.temporal.io/sdk/worker"

)

func ReplayWorkflow(ctx context.Context, client client.Client, id, runID string) error {

	hist, err := GetWorkflowHistory(ctx, client, id, runID)

	if err != nil {

		return err

	}

	replayer := worker.NewWorkflowReplayer()

	replayer.RegisterWorkflow(YourWorkflow)

	return replayer.ReplayWorkflowHistory(nil, hist)

}
```

The code above will cause the Worker to re-execute the Workflow's Workflow Function using the original Event History.
If a noticeably different code path was followed or some code caused a deadlock, it will be returned in the error code.
Replaying a Workflow Execution locally is a good way to see exactly what code path was taken for given input and events.

You can replay many Event Histories by registering all the needed Workflow implementation and then calling `ReplayWorkflowHistory` repeatedly.

**Tags:**

- [Testing](https://docs.temporal.io/tags/testing)
- [Go SDK](https://docs.temporal.io/tags/go-sdk)
- [Temporal SDKs](https://docs.temporal.io/tags/temporal-sd-ks)

Help us make Temporal better. Contribute to our [documentation](https://github.com/temporalio/documentation).

[Previous\\
\\
Debugging](https://docs.temporal.io/develop/go/best-practices/debugging) [Next\\
\\
Data handling](https://docs.temporal.io/develop/go/data-handling)

- [Test frameworks](https://docs.temporal.io/develop/go/best-practices/testing-suite#test-frameworks)
- [Test setup](https://docs.temporal.io/develop/go/best-practices/testing-suite#test-setup)
- [Testing Activities](https://docs.temporal.io/develop/go/best-practices/testing-suite#test-activities)
- [Mock and override Activities](https://docs.temporal.io/develop/go/best-practices/testing-suite#mock-and-override-activities)
  - [Run an Activity](https://docs.temporal.io/develop/go/best-practices/testing-suite#run-an-activity)
  - [Listen to Heartbeats](https://docs.temporal.io/develop/go/best-practices/testing-suite#listen-to-heartbeats)
  - [Cancel an Activity](https://docs.temporal.io/develop/go/best-practices/testing-suite#cancel-an-activity)
- [Mock and override Nexus operations](https://docs.temporal.io/develop/go/best-practices/testing-suite#mock-and-override-nexus-operations)
- [Testing Workflows](https://docs.temporal.io/develop/go/best-practices/testing-suite#test-workflows)
  - [Query tests](https://docs.temporal.io/develop/go/best-practices/testing-suite#query-tests)
  - [How to mock Activities](https://docs.temporal.io/develop/go/best-practices/testing-suite#mock-activities)
  - [How to skip time](https://docs.temporal.io/develop/go/best-practices/testing-suite#skip-time)
    - [Set up time skipping](https://docs.temporal.io/develop/go/best-practices/testing-suite#setting-up)
    - [Skip time in Activities](https://docs.temporal.io/develop/go/best-practices/testing-suite#skip-time-in-activities)
- [How to Replay a Workflow Execution](https://docs.temporal.io/develop/go/best-practices/testing-suite#replay)

- [GitHub](https://github.com/temporalio)
- [Twitter](https://x.com/temporalio)
- [YouTube](https://www.youtube.com/c/Temporalio)
- [About the docs](https://github.com/temporalio/documentation/blob/main/README.md)

- [Temporal Cloud](https://temporal.io/cloud)
- [Meetups](https://temporal.io/community#events)
- [Support forum](https://community.temporal.io/)
- [Ask an expert](https://pages.temporal.io/ask-an-expert)

- [Learn Temporal](https://learn.temporal.io/)
- [Blog](https://temporal.io/blog)
- [Use cases](https://temporal.io/in-use)
- [Newsletter signup](https://pages.temporal.io/newsletter-subscribe)

- [Security](https://docs.temporal.io/security)
- [Privacy policy](https://temporal.io/global-privacy-policy)
- [Terms of service](https://temporal.io/terms-of-service)
- [We're hiring](https://temporal.io/careers)

[![Temporal logo](https://docs.temporal.io/img/favicon.png)](https://temporal.io/)

Copyright © 2026 Temporal Technologies Inc.

Feedback

reCAPTCHA

Recaptcha requires verification.

protected by **reCAPTCHA**