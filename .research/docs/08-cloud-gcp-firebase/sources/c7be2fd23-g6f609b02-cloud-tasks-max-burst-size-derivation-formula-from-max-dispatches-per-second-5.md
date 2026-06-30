[Libraries](https://www.rubydoc.info/gems) » google-cloud-tasks-v2beta2 (0.13.0) » [Index](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/index) » [Google](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google "Google \(module\)") » [Cloud](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud "Google::Cloud \(module\)") » [Tasks](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks "Google::Cloud::Tasks \(module\)") » [V2beta2](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2 "Google::Cloud::Tasks::V2beta2 \(module\)") » [RateLimits](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/RateLimits "Google::Cloud::Tasks::V2beta2::RateLimits \(class\)") » #max_burst_size
[ ](https://www.rubydoc.info/list/gems/google-cloud-tasks-v2beta2/0.13.0/class)
# Method: Google::Cloud::Tasks::V2beta2::RateLimits#max_burst_size 

Defined in:
     proto_docs/google/cloud/tasks/v2beta2/queue.rb 
###  [permalink](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google%2FCloud%2FTasks%2FV2beta2%2FRateLimits:max_burst_size) #**max_burst_size** ⇒ `::Integer`
Returns The max burst size.
Max burst size limits how fast tasks in queue are processed when many tasks are in the queue and the rate is high. This field allows the queue to have a high rate so processing starts shortly after a task is enqueued, but still limits resource usage when many tasks are enqueued in a short period of time.
The [token bucket](https://wikipedia.org/wiki/Token_Bucket) algorithm is used to control the rate of task dispatches. Each queue has a token bucket that holds tokens, up to the maximum specified by `max_burst_size`. Each time a task is dispatched, a token is removed from the bucket. Tasks will be dispatched until the queue's bucket runs out of tokens. The bucket will be continuously refilled with new tokens based on [max_dispatches_per_second][RateLimits.max_dispatches_per_second].
The default value of `max_burst_size` is picked by Cloud Tasks based on the value of [max_dispatches_per_second][RateLimits.max_dispatches_per_second].
The maximum value of `max_burst_size` is 500.
For App Engine queues that were created or updated using `queue.yaml/xml`, `max_burst_size` is equal to [bucket_size](https://cloud.google.com/appengine/docs/standard/python/config/queueref#bucket_size). If [UpdateQueue](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/CloudTasks/Client#update_queue-instance_method "Google::Cloud::Tasks::V2beta2::CloudTasks::Client#update_queue \(method\)") is called on a queue without explicitly setting a value for `max_burst_size`, `max_burst_size` value will get updated if [UpdateQueue](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/CloudTasks/Client#update_queue-instance_method "Google::Cloud::Tasks::V2beta2::CloudTasks::Client#update_queue \(method\)") is updating [max_dispatches_per_second][RateLimits.max_dispatches_per_second].
Returns:
  * (`::Integer`) — 
The max burst size.
Max burst size limits how fast tasks in queue are processed when many tasks are in the queue and the rate is high. This field allows the queue to have a high rate so processing starts shortly after a task is enqueued, but still limits resource usage when many tasks are enqueued in a short period of time.
The [token bucket](https://wikipedia.org/wiki/Token_Bucket) algorithm is used to control the rate of task dispatches. Each queue has a token bucket that holds tokens, up to the maximum specified by `max_burst_size`. Each time a task is dispatched, a token is removed from the bucket. Tasks will be dispatched until the queue's bucket runs out of tokens. The bucket will be continuously refilled with new tokens based on [max_dispatches_per_second][RateLimits.max_dispatches_per_second].
The default value of `max_burst_size` is picked by Cloud Tasks based on the value of [max_dispatches_per_second][RateLimits.max_dispatches_per_second].
The maximum value of `max_burst_size` is 500.
For App Engine queues that were created or updated using `queue.yaml/xml`, `max_burst_size` is equal to [bucket_size](https://cloud.google.com/appengine/docs/standard/python/config/queueref#bucket_size). If [UpdateQueue](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/CloudTasks/Client#update_queue-instance_method "Google::Cloud::Tasks::V2beta2::CloudTasks::Client#update_queue \(method\)") is called on a queue without explicitly setting a value for `max_burst_size`, `max_burst_size` value will get updated if [UpdateQueue](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/CloudTasks/Client#update_queue-instance_method "Google::Cloud::Tasks::V2beta2::CloudTasks::Client#update_queue \(method\)") is updating [max_dispatches_per_second][RateLimits.max_dispatches_per_second].


[[View source](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/RateLimits:max_burst_size)]  
|  
```


282
283
284
285
```
 |  
```
# File 'proto_docs/google/cloud/tasks/v2beta2/queue.rb', line 282

class RateLimits[](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Cloud/Tasks/V2beta2/RateLimits "Google::Cloud::Tasks::V2beta2::RateLimits \(class\)")
  include ::Google[](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google "Google \(module\)")::Protobuf[](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Protobuf "Google::Protobuf \(module\)")::MessageExts
  extend ::Google[](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google "Google \(module\)")::Protobuf[](https://www.rubydoc.info/gems/google-cloud-tasks-v2beta2/0.13.0/Google/Protobuf "Google::Protobuf \(module\)")::MessageExts::ClassMethods
end
```
 |  
| --- | --- |  
Generated on Tue Jun 30 20:52:22 2026 by [yard](https://yardoc.org "Yay! A Ruby Documentation Tool") 0.9.44 (ruby-4.0.5). 

