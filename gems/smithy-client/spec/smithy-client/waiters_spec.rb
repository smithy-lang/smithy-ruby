# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    module Waiters
      describe Waiters do
        let(:shapes) do
          {
            "smithy.ruby.tests#BooleanArray" => {
              "type" => "list",
              "member" => {
                "target" => "smithy.api#Boolean"
              }
            },
            "smithy.ruby.tests#Child" => {
              "type" => "structure",
              "members" => {
                "grandchildren" => {
                  "target" => "smithy.ruby.tests#GrandchildArray"
                }
              }
            },
            "smithy.ruby.tests#ChildArray" => {
              "type" => "list",
              "member" => {
                "target" => "smithy.ruby.tests#Child"
              }
            },
            "smithy.ruby.tests#DataMap" => {
              "type" => "map",
              "key" => {
                "target" => "smithy.api#String"
              },
              "value" => {
                "target" => "smithy.api#String"
              }
            },
            "smithy.ruby.tests#DeleteWidget" => {
              "type" => "operation",
              "input" => {
                "target" => "smithy.ruby.tests#WidgetInput"
              },
              "output" => {
                "target" => "smithy.ruby.tests#DeletedWidgetOutput"
              },
              "errors" => [
                {
                  "target" => "smithy.ruby.tests#MyError"
                },
                {
                  "target" => "smithy.ruby.tests#WidgetDoesNotExistError"
                }
              ],
              "traits" => {
                "smithy.api#http" => {
                  "uri" => "/delete-widget",
                  "method" => "POST"
                },
                "smithy.waiters#waitable" => {
                  "AcceptorOrderSuccessMatcher" => {
                    "documentation" => "Matcher with multiple acceptors",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "errorType" => "WidgetDoesNotExistError"
                        }
                      },
                      {
                        "state" => "failure",
                        "matcher" => {
                          "errorType" => "WidgetDoesNotExistError"
                        }
                      }
                    ]
                  },
                  "AcceptorOrderFailureMatcher" => {
                    "documentation" => "Matcher with multiple acceptors",
                    "acceptors" => [
                      {
                        "state" => "failure",
                        "matcher" => {
                          "errorType" => "WidgetDoesNotExistError"
                        }
                      },
                      {
                        "state" => "success",
                        "matcher" => {
                          "errorType" => "WidgetDoesNotExistError"
                        }
                      }
                    ]
                  },
                  "FullyConfiguredMatcher" => {
                    "documentation" => "Fully configured waiter",
                    "acceptors" => [
                      {
                        "state" => "retry",
                        "matcher" => {
                          "errorType" => "WidgetDoesNotExistError"
                        }
                      },
                      {
                        "state" => "failure",
                        "matcher" => {
                          "output" => {
                            "path" => "stringProperty",
                            "expected" => "fail",
                            "comparator" => "stringEquals"
                          }
                        }
                      },
                      {
                        "state" => "success",
                        "matcher" => {
                          "success" => true
                        }
                      }
                    ],
                    "minDelay" => 5,
                    "maxDelay" => 20,
                    "deprecated" => true,
                    "tags" => %w[some tags]
                  }
                }
              }
            },
            "smithy.ruby.tests#DeletedWidgetOutput" => {
              "type" => "structure",
              "members" => {
                "stringProperty" => {
                  "target" => "smithy.api#String"
                }
              }
            },
            "smithy.ruby.tests#GetWidget" => {
              "type" => "operation",
              "input" => {
                "target" => "smithy.ruby.tests#WidgetInput"
              },
              "output" => {
                "target" => "smithy.ruby.tests#WidgetOutput"
              },
              "errors" => [
                {
                  "target" => "smithy.ruby.tests#MyError"
                }
              ],
              "traits" => {
                "smithy.api#http" => {
                  "uri" => "/widget",
                  "method" => "POST"
                },
                "smithy.waiters#waitable" => {
                  "SuccessTrueMatcher" => {
                    "documentation" => "Acceptor matches on successful request",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "success" => true
                        }
                      }
                    ]
                  },
                  "SuccessFalseMatcher" => {
                    "documentation" => "Acceptor matches on unsuccessful request",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "success" => false
                        }
                      }
                    ]
                  },
                  "ErrorTypeMatcher" => {
                    "documentation" => "Acceptor matches on receipt of specified error",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "errorType" => "MyError"
                        }
                      }
                    ]
                  },
                  "OutputStringPropertyMatcher" => {
                    "documentation" => "Acceptor matches on output payload property",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "stringProperty",
                            "expected" => "expected string",
                            "comparator" => "stringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "OutputBooleanPropertyMatcher" => {
                    "documentation" => "Acceptor matches on output payload property",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "booleanProperty",
                            "expected" => "false",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  },
                  "OutputStringArrayAllPropertyMatcher" => {
                    "documentation" => "Acceptor matches on output payload property",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "stringArrayProperty",
                            "expected" => "expected string",
                            "comparator" => "allStringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "OutputStringArrayAnyPropertyMatcher" => {
                    "documentation" => "Acceptor matches on output payload property",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "stringArrayProperty",
                            "expected" => "expected string",
                            "comparator" => "anyStringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "InputOutputStringPropertyMatcher" => {
                    "documentation" => "Acceptor matches on string property of input and output",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "inputOutput" => {
                            "path" => "input.stringProperty",
                            "expected" => "output.stringProperty",
                            "comparator" => "stringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "InputOutputBooleanPropertyMatcher" => {
                    "documentation" => "Acceptor matches on input property equaling output property",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "inputOutput" => {
                            "path" => "input.stringProperty == output.stringProperty",
                            "expected" => "true",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  },
                  "InputOutputStringArrayAllPropertyMatcher" => {
                    "documentation" => "Acceptor matches on string array property of input and output",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "inputOutput" => {
                            "path" => "input.stringArrayProperty",
                            "expected" => "output.stringArrayProperty",
                            "comparator" => "allStringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "InputOutputStringArrayAnyPropertyMatcher" => {
                    "documentation" => "Acceptor matches on string array property of input and output",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "inputOutput" => {
                            "path" => "input.stringArrayProperty",
                            "expected" => "output.stringArrayProperty",
                            "comparator" => "anyStringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "FlattenMatcher" => {
                    "documentation" => "Matches when any grandchild has name 'expected name'",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "children[].grandchildren[].name",
                            "expected" => "expected name",
                            "comparator" => "anyStringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "FlattenLengthMatcher" => {
                    "documentation" => "Matches when there are 6 grandchildren total",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "length(children[].grandchildren[]) == `6`",
                            "expected" => "true",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  },
                  "FlattenFilterMatcher" => {
                    "documentation" => "Matches when exactly one child has 3 grandchildren",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "length(children[?length(grandchildren) == `3`]) == `1`",
                            "expected" => "true",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  },
                  "LengthFlattenFilterMatcher" => {
                    "documentation" => "Matches when exactly 3 grandchildren have numbers above 4",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "length((children[].grandchildren[])[?number > `4`]) == `3`",
                            "expected" => "true",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  },
                  "ProjectionMatcher" => {
                    "documentation" => "Matches when dataMap values are all `abc`",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "dataMap.*",
                            "expected" => "abc",
                            "comparator" => "allStringEquals"
                          }
                        }
                      }
                    ]
                  },
                  "ContainsFieldMatcher" => {
                    "documentation" => "Matches when any value of dataMap is the same as stringProperty",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "contains(dataMap.*, stringProperty)",
                            "expected" => "true",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  },
                  "AndInequalityMatcher" => {
                    "documentation" => "Matches when there are three elements in dataMap but not three in stringArrayProperty",
                    "acceptors" => [
                      {
                        "state" => "success",
                        "matcher" => {
                          "output" => {
                            "path" => "length(dataMap) == `3` && length(stringArrayProperty) != `3`",
                            "expected" => "true",
                            "comparator" => "booleanEquals"
                          }
                        }
                      }
                    ]
                  }
                }
              }
            },
            "smithy.ruby.tests#Grandchild" => {
              "type" => "structure",
              "members" => {
                "name" => {
                  "target" => "smithy.api#String"
                },
                "number" => {
                  "target" => "smithy.api#Integer"
                }
              }
            },
            "smithy.ruby.tests#GrandchildArray" => {
              "type" => "list",
              "member" => {
                "target" => "smithy.ruby.tests#Grandchild"
              }
            },
            "smithy.ruby.tests#MyError" => {
              "type" => "structure",
              "members" => {
                "message" => {
                  "target" => "smithy.api#String"
                }
              },
              "traits" => {
                "smithy.api#error" => "client"
              }
            },
            "smithy.ruby.tests#StringArray" => {
              "type" => "list",
              "member" => {
                "target" => "smithy.api#String"
              }
            },
            "smithy.ruby.tests#WaitService" => {
              "type" => "service",
              "version" => "2022-11-30",
              "operations" => [
                {
                  "target" => "smithy.ruby.tests#DeleteWidget"
                },
                {
                  "target" => "smithy.ruby.tests#GetWidget"
                }
              ]
            },
            "smithy.ruby.tests#WidgetDoesNotExistError" => {
              "type" => "structure",
              "members" => {
                "message" => {
                  "target" => "smithy.api#String"
                }
              },
              "traits" => {
                "smithy.api#error" => "client"
              }
            },
            "smithy.ruby.tests#WidgetInput" => {
              "type" => "structure",
              "members" => {
                "stringProperty" => {
                  "target" => "smithy.api#String"
                },
                "stringArrayProperty" => {
                  "target" => "smithy.ruby.tests#StringArray"
                },
                "booleanProperty" => {
                  "target" => "smithy.api#Boolean"
                },
                "booleanArrayProperty" => {
                  "target" => "smithy.ruby.tests#BooleanArray"
                },
                "children" => {
                  "target" => "smithy.ruby.tests#ChildArray"
                },
                "dataMap" => {
                  "target" => "smithy.ruby.tests#DataMap"
                }
              }
            },
            "smithy.ruby.tests#WidgetOutput" => {
              "type" => "structure",
              "members" => {
                "stringProperty" => {
                  "target" => "smithy.api#String"
                },
                "stringArrayProperty" => {
                  "target" => "smithy.ruby.tests#StringArray"
                },
                "booleanProperty" => {
                  "target" => "smithy.api#Boolean"
                },
                "booleanArrayProperty" => {
                  "target" => "smithy.ruby.tests#BooleanArray"
                },
                "children" => {
                  "target" => "smithy.ruby.tests#ChildArray"
                },
                "dataMap" => {
                  "target" => "smithy.ruby.tests#DataMap"
                }
              }
            },
            "smithy.waiters#Acceptor" => {
              "type" => "structure",
              "members" => {
                "state" => {
                  "target" => "smithy.waiters#AcceptorState",
                  "traits" => {
                    "smithy.api#documentation" => "The state the acceptor transitions to when matched.",
                    "smithy.api#required" => {}
                  }
                },
                "matcher" => {
                  "target" => "smithy.waiters#Matcher",
                  "traits" => {
                    "smithy.api#documentation" => "The matcher used to test if the resource is in a given state.",
                    "smithy.api#required" => {}
                  }
                }
              },
              "traits" => {
                "smithy.api#documentation" => "Represents an acceptor in a waiter's state machine.",
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#AcceptorState" => {
              "type" => "enum",
              "members" => {
                "SUCCESS" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "The waiter successfully finished waiting. This is a terminal\nstate that causes the waiter to stop.",
                    "smithy.api#enumValue" => "success"
                  }
                },
                "FAILURE" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "The waiter failed to enter into the desired state. This is a\nterminal state that causes the waiter to stop.",
                    "smithy.api#enumValue" => "failure"
                  }
                },
                "RETRY" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "The waiter will retry the operation. This state transition is\nimplicit if no accepter causes a state transition.",
                    "smithy.api#enumValue" => "retry"
                  }
                }
              },
              "traits" => {
                "smithy.api#documentation" => "The transition state of a waiter.",
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#Acceptors" => {
              "type" => "list",
              "member" => {
                "target" => "smithy.waiters#Acceptor"
              },
              "traits" => {
                "smithy.api#length" => {
                  "min" => 1
                },
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#Matcher" => {
              "type" => "union",
              "members" => {
                "output" => {
                  "target" => "smithy.waiters#PathMatcher",
                  "traits" => {
                    "smithy.api#documentation" => "Matches on the successful output of an operation using a\nJMESPath expression."
                  }
                },
                "inputOutput" => {
                  "target" => "smithy.waiters#PathMatcher",
                  "traits" => {
                    "smithy.api#documentation" => "Matches on both the input and output of an operation using a JMESPath\nexpression. Input parameters are available through the top-level\n`input` field, and output data is available through the top-level\n`output` field. This matcher can only be used on operations that\ndefine both input and output. This matcher is checked only if an\noperation completes successfully."
                  }
                },
                "errorType" => {
                  "target" => "smithy.api#String",
                  "traits" => {
                    "smithy.api#documentation" => "Matches if an operation returns an error and the error matches\nthe expected error type. If an absolute shape ID is provided, the\nerror is matched exactly on the shape ID. A shape name can be\nprovided to match an error in any namespace with the given name."
                  }
                },
                "success" => {
                  "target" => "smithy.api#Boolean",
                  "traits" => {
                    "smithy.api#documentation" => "When set to `true`, matches when an operation returns a successful\nresponse. When set to `false`, matches when an operation fails with\nany error."
                  }
                }
              },
              "traits" => {
                "smithy.api#documentation" => "Defines how an acceptor determines if it matches the current state of\na resource.",
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#NonEmptyString" => {
              "type" => "string",
              "traits" => {
                "smithy.api#length" => {
                  "min" => 1
                },
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#NonEmptyStringList" => {
              "type" => "list",
              "member" => {
                "target" => "smithy.waiters#NonEmptyString"
              },
              "traits" => {
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#PathComparator" => {
              "type" => "enum",
              "members" => {
                "STRING_EQUALS" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "Matches if the return value is a string that is equal to the expected string.",
                    "smithy.api#enumValue" => "stringEquals"
                  }
                },
                "BOOLEAN_EQUALS" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "Matches if the return value is a boolean that is equal to the string literal 'true' or 'false'.",
                    "smithy.api#enumValue" => "booleanEquals"
                  }
                },
                "ALL_STRING_EQUALS" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "Matches if all values in the list matches the expected string.",
                    "smithy.api#enumValue" => "allStringEquals"
                  }
                },
                "ANY_STRING_EQUALS" => {
                  "target" => "smithy.api#Unit",
                  "traits" => {
                    "smithy.api#documentation" => "Matches if any value in the list matches the expected string.",
                    "smithy.api#enumValue" => "anyStringEquals"
                  }
                }
              },
              "traits" => {
                "smithy.api#documentation" => "Defines a comparison to perform in a PathMatcher.",
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#PathMatcher" => {
              "type" => "structure",
              "members" => {
                "path" => {
                  "target" => "smithy.api#String",
                  "traits" => {
                    "smithy.api#documentation" => "A JMESPath expression applied to the input or output of an operation.",
                    "smithy.api#required" => {}
                  }
                },
                "expected" => {
                  "target" => "smithy.api#String",
                  "traits" => {
                    "smithy.api#documentation" => "The expected return value of the expression.",
                    "smithy.api#required" => {}
                  }
                },
                "comparator" => {
                  "target" => "smithy.waiters#PathComparator",
                  "traits" => {
                    "smithy.api#documentation" => "The comparator used to compare the result of the expression with the\nexpected value.",
                    "smithy.api#required" => {}
                  }
                }
              },
              "traits" => {
                "smithy.api#documentation" => "Defines how to test the result of a JMESPath expression against\nan expected value.",
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#Waiter" => {
              "type" => "structure",
              "members" => {
                "documentation" => {
                  "target" => "smithy.api#String",
                  "traits" => {
                    "smithy.api#documentation" => "Documentation about the waiter. Can use CommonMark."
                  }
                },
                "acceptors" => {
                  "target" => "smithy.waiters#Acceptors",
                  "traits" => {
                    "smithy.api#documentation" => "An ordered array of acceptors to check after executing an operation.",
                    "smithy.api#required" => {}
                  }
                },
                "minDelay" => {
                  "target" => "smithy.waiters#WaiterDelay",
                  "traits" => {
                    "smithy.api#default" => 2,
                    "smithy.api#documentation" => "The minimum amount of time in seconds to delay between each retry.\nThis value defaults to 2 if not specified. If specified, this value\nMUST be greater than or equal to 1 and less than or equal to\n`maxDelay`."
                  }
                },
                "maxDelay" => {
                  "target" => "smithy.waiters#WaiterDelay",
                  "traits" => {
                    "smithy.api#default" => 120,
                    "smithy.api#documentation" => "The maximum amount of time in seconds to delay between each retry.\nThis value defaults to 120 if not specified (or, 2 minutes). If\nspecified, this value MUST be greater than or equal to 1."
                  }
                },
                "deprecated" => {
                  "target" => "smithy.api#Boolean",
                  "traits" => {
                    "smithy.api#documentation" => "Indicates if the waiter is considered deprecated. A waiter SHOULD\nbe marked as deprecated if it has been replaced by another waiter or\nif it is no longer needed (for example, if a resource changes from\neventually consistent to strongly consistent)."
                  }
                },
                "tags" => {
                  "target" => "smithy.waiters#NonEmptyStringList",
                  "traits" => {
                    "smithy.api#documentation" => "A list of tags associated with the waiter that allow waiters to be\ncategorized and grouped."
                  }
                }
              },
              "traits" => {
                "smithy.api#documentation" => "Defines an individual operation waiter.",
                "smithy.api#private" => {}
              }
            },
            "smithy.waiters#WaiterDelay" => {
              "type" => "integer",
              "traits" => {
                "smithy.api#range" => {
                  "min" => 1
                }
              }
            },
            "smithy.waiters#WaiterName" => {
              "type" => "string",
              "traits" => {
                "smithy.api#pattern" => "^[A-Z]+[A-Za-z0-9]*$"
              }
            },
            "smithy.waiters#waitable" => {
              "type" => "map",
              "key" => {
                "target" => "smithy.waiters#WaiterName"
              },
              "value" => {
                "target" => "smithy.waiters#Waiter"
              },
              "traits" => {
                "smithy.api#documentation" => "Indicates that an operation has various named \"waiters\" that can be used\nto poll a resource until it enters a desired state.",
                "smithy.api#length" => {
                  "min" => 1
                },
                "smithy.api#trait" => {
                  "selector" => "operation :not(-[input, output]-> structure > member > union[trait|streaming])"
                }
              }
            }
          }
        end
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(Smithy::Client::Plugins::StubResponses)
          client_class
        end
        let(:client) { client_class.new(stub_responses: true) }
        let(:input) { { string_property: 'input_string' } }
        let(:waiter) { Waiter }
        let(:my_error) { sample_client::Errors::MyError.new({}, message: 'my error message') }
        let(:widget_does_not_exist_error) {
          sample_client::Errors::WidgetDoesNotExistError.new({}, message: 'widget does not exist message')
        }
        let(:unexpected_error) { Errors::UnexpectedError }
        let(:failure_state_error) { Errors::FailureStateError }
        let(:max_wait_time_exceeded_error) { Errors::MaxWaitTimeExceededError }
        let(:no_such_waiter_error) { Errors::NoSuchWaiterError }

        describe 'success matcher' do
          it 'succeeds when success is set to true and successful response is received' do
            output = {}
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until(:success_true_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'succeeds when success is set to false and error is received' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_false_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'retries and succeeds when matched' do
            output = {}
            2.times do
              expect(client).to receive(:get_widget).and_return(output)
            end
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_false_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'fails when success is set to true and unexpected error is received' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:success_true_matcher, input, max_wait_time: 60)
            }.to raise_error(unexpected_error)
          end
        end

        describe 'error type matcher' do
          it 'succeeds when error matches' do
            expect(client).to receive(:get_widget).and_raise(my_error)
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'retries and succeeds when matched' do
            output = {}
            2.times do
              expect(client).to receive(:get_widget).and_return(output)
              expect_any_instance_of(waiter).to receive(:delay).and_call_original
            end
            expect(client).to receive(:get_widget).and_raise(my_error)
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end

          it 'fails when error does not match' do
            expect(client).to receive(:get_widget).and_raise(StandardError)
            expect {
              client.wait_until(:error_type_matcher, input, max_wait_time: 60)
            }.to raise_error(unexpected_error)
          end
        end

        describe 'output matcher' do
          context 'string equals comparator' do
            it 'succeeds when output matches' do
              output = { string_property: 'expected string' }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries and succeeds when matched' do
              output_expected = { string_property: 'expected string' }
              output_unexpected = { string_property: 'unexpected string' }
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = { string_property: 'unexpected string' }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'boolean equals comparator' do
            it 'succeeds when output matches' do
              output = { boolean_property: false }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries and succeeds when matched' do
              output_expected = { boolean_property: false }
              output_unexpected = { boolean_property: true }
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = { boolean_property: true }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_boolean_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'all string equals comparator' do
            it 'succeeds when output matches' do
              output = {
                string_array_property: [
                  'expected string',
                  'expected string',
                  'expected string'
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries and succeeds when matched' do
              output_expected = {
                string_array_property: [
                  'expected string',
                  'expected string',
                  'expected string'
                ]
              }
              output_unexpected = {
                string_array_property: [
                  'expected string',
                  'unexpected string',
                  'unexpected string'
                ]
              }
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = {
                string_array_property: [
                  'expected string',
                  'unexpected string',
                  'unexpected string'
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is empty' do
              output_unexpected = { string_array_property: [] }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_all_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'any string equals comparator' do
            it 'succeeds when output matches' do
              output = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'expected string',
                  'yet another string'
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'retries and succeeds when matched' do
              output_expected = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'expected string',
                  'yet another string'
                ]
              }
              output_unexpected = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'unexpected string',
                  'yet another string'
                ]
              }
              2.times do
                expect(client).to receive(:get_widget).and_return(output_unexpected)
                expect_any_instance_of(waiter).to receive(:delay).and_call_original
              end
              expect(client).to receive(:get_widget).and_return(output_expected)
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when output property does not match' do
              output_unexpected = {
                string_array_property: [
                  'some other string',
                  'another string',
                  'unexpected string',
                  'yet another string'
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is empty' do
              output_unexpected = { string_array_property: [] }
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end

            it 'fails when output property is null' do
              output_unexpected = {}
              2.times do
                allow(client).to receive(:get_widget).and_return(output_unexpected)
              end
              expect {
                client.wait_until(:output_string_array_any_property_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'flatten' do
            it 'succeeds when matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'expected name',
                        number: 1
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'unexpected name',
                        number: 1
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:flatten_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'unexpected name',
                        number: 1
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:flatten_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'flatten length' do
            it 'succeeds when matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 4
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 5
                      },
                      {
                        name: 'name',
                        number: 6
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:flatten_length_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:flatten_length_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'flatten filter' do
            it 'succeeds when matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 4
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 5
                      },
                      {
                        name: 'name',
                        number: 6
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:flatten_filter_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 4
                      },
                      {
                        name: 'name',
                        number: 5
                      },
                      {
                        name: 'name',
                        number: 6
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:flatten_filter_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'length flatten filter' do
            it 'succeeds when matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 5
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 6
                      },
                      {
                        name: 'name',
                        number: 7
                      }
                    ]
                  }
                ]
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:length_flatten_filter_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                children: [
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 1
                      },
                      {
                        name: 'name',
                        number: 2
                      },
                      {
                        name: 'name',
                        number: 3
                      }
                    ]
                  },
                  {
                    grandchildren: [
                      {
                        name: 'name',
                        number: 3
                      },
                      {
                        name: 'name',
                        number: 4
                      },
                      {
                        name: 'name',
                        number: 5
                      }
                    ]
                  }
                ]
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:length_flatten_filter_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'projection' do
            it 'succeeds when matched' do
              output = {
                data_map: {
                  'key1' => 'abc',
                  'key2' => 'abc',
                  'key3' => 'abc',
                }
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:projection_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                data_map: {
                  'key1' => 'abc',
                  'key2' => 'def',
                  'key3' => 'ghi',
                }
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:projection_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'contains field' do
            it 'succeeds when matched' do
              output = {
                string_property: 'match',
                data_map: {
                  'key1' => 'not a match',
                  'key2' => 'match',
                  'key3' => 'not a match',
                }
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:contains_field_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                string_property: 'match',
                data_map: {
                  'key1' => 'not a match',
                  'key2' => 'not a match',
                  'key3' => 'not a match',
                }
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:contains_field_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end

          context 'and inequality' do
            it 'succeeds when matched' do
              output = {
                string_array_property: [
                  'some string',
                  'another string'
                ],
                data_map: {
                  'key1' => 'one',
                  'key2' => 'two',
                  'key3' => 'three',
                }
              }
              expect(client).to receive(:get_widget).and_return(output)
              expect {
                client.wait_until(:and_inequality_matcher, input, max_wait_time: 60)
              }.to_not raise_error
            end

            it 'fails when not matched' do
              output = {
                string_array_property: [
                  'some string',
                  'another string',
                  'yet another string'
                ],
                data_map: {
                  'key1' => 'one',
                  'key2' => 'two',
                  'key3' => 'three',
                }
              }
              2.times do
                allow(client).to receive(:get_widget).and_return(output)
              end
              expect {
                client.wait_until(:and_inequality_matcher, input, max_wait_time: 2)
              }.to raise_error(max_wait_time_exceeded_error)
            end
          end
        end

        describe 'input output matcher' do
          it 'succeeds for boolean equals comparator' do
            output = { string_property: 'input_string' }
            expect(client).to receive(:get_widget).and_return(output)
            expect {
              client.wait_until(:input_output_boolean_property_matcher, input, max_wait_time: 60)
            }.to_not raise_error
          end
        end

        it 'checks acceptors in order' do
          expect(client).to receive(:delete_widget).and_raise(widget_does_not_exist_error)
          expect {
            client.wait_until(:acceptor_order_success_matcher, input, max_wait_time: 60)
          }.to_not raise_error

          expect(client).to receive(:delete_widget).and_raise(widget_does_not_exist_error)
          expect {
            client.wait_until(:acceptor_order_failure_matcher, input, max_wait_time: 60)
          }.to raise_error(failure_state_error)
        end

        it 'allows configuration of min and max delay' do
          options = {
            max_wait_time: 5,
            min_delay: 3,
            max_delay: 4
          }
          output = {}
          2.times do
            allow(client).to receive(:get_widget).and_return(output)
          end
          expect_any_instance_of(waiter).to receive(:delay).and_wrap_original do |m, *args|
            delay = m.call(*args)
            expect(delay).to equal(5)
            delay
          end
          expect {
            client.wait_until(:success_false_matcher, input, options)
          }.to raise_error(max_wait_time_exceeded_error)
        end

        it 'raises an error when max wait time is exceeded' do
          output = {}
          5.times do
            allow(client).to receive(:get_widget).and_return(output)
          end
          expect {
            client.wait_until(:success_false_matcher, input, max_wait_time: 2)
          }.to raise_error(max_wait_time_exceeded_error)
        end

        it 'raises an error when max_wait_time is not provided' do
          expect {
            client.wait_until(:success_true_matcher, input)
          }.to raise_error(ArgumentError, "expected `:max_wait_time` to be an integer, got: #{nil}")
        end

        it 'raises an error when max_delay is less than 1' do
          options = {
            max_wait_time: 5,
            max_delay: 0
          }
          expect {
            client.wait_until(:success_true_matcher, input, options)
          }.to raise_error(ArgumentError, '`:max_delay` must be greater than 0')
        end

        it 'raises an error when min_delay is less than 1' do
          options = {
            max_wait_time: 5,
            min_delay: 0
          }
          expect {
            client.wait_until(:success_true_matcher, input, options)
          }.to raise_error(ArgumentError, '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`')
        end

        it 'raises an error when max_delay is less than min_delay' do
          options = {
            max_wait_time: 5,
            min_delay: 4,
            max_delay: 2
          }
          expect {
            client.wait_until(:success_true_matcher, input, options)
          }.to raise_error(ArgumentError, '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`')
        end
      end
    end
  end
end
