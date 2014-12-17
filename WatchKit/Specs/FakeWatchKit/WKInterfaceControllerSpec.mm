#import "Cedar.h"
#import "CorgisController.h"
#import "InterfaceController.h"
#import "InterfaceControllerLoader.h"
#import "WKInterfaceController.h"
#import "WKInterfaceButton+Spec.h"
#import "FakeSegue.h"


using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(WKInterfaceControllerSpec)

describe(@"WKInterfaceController", ^{
    __block InterfaceController *subject;
    __block InterfaceControllerLoader *loader;

    beforeEach(^{
        loader = [[InterfaceControllerLoader alloc] init];
        subject = [loader interfaceControllerWithStoryboardName:@"Interface" identifier:@"AgC-eL-Hgc"];

    });

    describe(@"public methods", ^{

        it(@"should record the invocations of awakeWithContext:", ^{
            [subject awakeWithContext:@1];

            subject should have_received(@selector(awakeWithContext:)).with(@1);
        });

        it(@"should record the invocations of willActivate", ^{
            subject should_not be_nil;
            [subject willActivate];

            subject should have_received(@selector(willActivate));
        });

        it(@"should record the invocations of didDeactivate", ^{
            [subject didDeactivate];

            subject should have_received(@selector(didDeactivate));
        });

        it(@"should record the invocations of table:didSelectRowAtIndex:", ^{
            WKInterfaceTable *table = [[WKInterfaceTable alloc] init];
            [subject table:table didSelectRowAtIndex:0];

            subject should have_received(@selector(table:didSelectRowAtIndex:)).with(table, 0);
        });

        it(@"should record the invocations of handleActionWithIdentifier:forRemoteNotification:", ^{
            [subject handleActionWithIdentifier:@"asdf" forRemoteNotification:@{@"a": @1}];
            subject should have_received(@selector(handleActionWithIdentifier:forRemoteNotification:)).with(@"asdf", @{@"a": @1});
        });

        it(@"should record the invocations of handleActionWithIdentifier:forLocalNotification:", ^{
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            [subject handleActionWithIdentifier:@"asdf" forLocalNotification:notification];
            subject should have_received(@selector(handleActionWithIdentifier:forLocalNotification:)).with(@"asdf", notification);
        });

        it(@"should record the invocations of handleActionWithIdentifier:forRemoteNotification:", ^{
            NSString *expectedContext = @"asdf";
            [subject actionForUserActivity:@{@"a": @1} context:&expectedContext];
            subject should have_received(@selector(actionForUserActivity:context:)).with(@{@"a": @1}, Arguments::anything);

            NSInvocation *invocation = [[subject sent_messages] firstObject];
            __autoreleasing NSString **contextPointer;
            [invocation getArgument:&contextPointer atIndex:3];
            NSString *context = *contextPointer;
            context should equal(@"asdf");
        });

        it(@"should record the invocations of setTitle:", ^{
            [subject setTitle:@"asdf"];
            subject should have_received(@selector(setTitle:)).with(@"asdf");
        });

        it(@"should record the invocations of pushControllerWithName:context:", ^{
            [subject pushControllerWithName:@"MyFirstCorgiController" context:[UIImage imageNamed:@"corgi.jpeg"]];

            subject should have_received(@selector(pushControllerWithName:context:)).with(@"MyFirstCorgiController", [UIImage imageNamed:@"corgi.jpeg"]);
        });

        it(@"should record the invocations of popController", ^{
            [subject popController];
            subject should have_received(@selector(popController));
        });

        it(@"should record the invocations of popToRootController", ^{
            [subject popToRootController];
            subject should have_received(@selector(popToRootController));
        });

        it(@"should record the invocations of becomeCurrentPage", ^{
            [subject becomeCurrentPage];

            subject should have_received(@selector(becomeCurrentPage));
        });

        it(@"should record the invocations of presentControllerWithName:context:", ^{
            [subject presentControllerWithName:@"MyFirstCorgiController" context:[UIImage imageNamed:@"corgi.jpeg"]];
            subject should have_received(@selector(presentControllerWithName:context:)).with(@"MyFirstCorgiController", [UIImage imageNamed:@"corgi.jpeg"]);
        });

        it(@"should record the invocations of presentControllerWithName:contexts:", ^{
            NSArray *names = @[@"sally", @"charlie"];
            NSArray *contexts = @[@2, @3];
            [subject presentControllerWithNames:names contexts:contexts];
            subject should have_received(@selector(presentControllerWithNames:contexts:)).with(names, contexts);
        });

        it(@"should record the invocations of dismissController", ^{
            [subject dismissController];

            subject should have_received(@selector(dismissController));
        });

        it(@"should record the invocations of presentTextInputControllerWithSuggestions:allowedInputMode:completion:", ^{
            [subject presentTextInputControllerWithSuggestions:@[@2, @3]
                                              allowedInputMode:WKTextInputModeAllowAnimatedEmoji
                                                    completion:nil];
            subject should have_received(@selector(presentTextInputControllerWithSuggestions:allowedInputMode:completion:)).with(@[@2, @3], WKTextInputModeAllowAnimatedEmoji, Arguments::anything);
        });

        it(@"should record the invocations of dismissTextInputController", ^{
            [subject dismissTextInputController];

            subject should have_received(@selector(dismissTextInputController));
        });

        it(@"should record the invocations of contextForSegueWithIdentifier:", ^{
            [subject contextForSegueWithIdentifier:@"asdf"];

            subject should have_received(@selector(contextForSegueWithIdentifier:)).with(@"asdf");
        });

        it(@"should record the invocations of contextsForSegueWithIdentifier:", ^{
            [subject contextsForSegueWithIdentifier:@"asdf"];

            subject should have_received(@selector(contextsForSegueWithIdentifier:)).with(@"asdf");
        });

        it(@"should record the invocations of contextForSegueWithIdentifier:inTable:rowIndex:", ^{
            WKInterfaceTable *table = [[WKInterfaceTable alloc] init];
            [subject contextForSegueWithIdentifier:@"zxcv"
                                           inTable:table
                                          rowIndex:3];

            subject should have_received(@selector(contextForSegueWithIdentifier:inTable:rowIndex:)).with(@"zxcv", table, 3);
        });

        it(@"should record the invocations of contextsForSegueWithIdentifier:inTable:rowIndex:", ^{
            WKInterfaceTable *table = [[WKInterfaceTable alloc] init];
            [subject contextsForSegueWithIdentifier:@"zxcv"
                                           inTable:table
                                          rowIndex:3];

            subject should have_received(@selector(contextsForSegueWithIdentifier:inTable:rowIndex:)).with(@"zxcv", table, 3);
        });

        it(@"should record the invocations of addMenuItemWithImage:title:action:", ^{
            UIImage *image = [[UIImage alloc] init];
            [subject addMenuItemWithImage:image title:@"asdf" action:@selector(init)];

            subject should have_received(@selector(addMenuItemWithImage:title:action:)).with(image, @"asdf", @selector(init));
        });

        it(@"should record the invocations of addMenuItemWithImageNamed:title:action:", ^{
            [subject addMenuItemWithImageNamed:@"corgi.jpeg" title:@"asdf" action:@selector(init)];

            subject should have_received(@selector(addMenuItemWithImageNamed:title:action:)).with(@"corgi.jpeg", @"asdf", @selector(init));
        });

        it(@"should record the invocations of addMenuItemWithItemIcon:title:action:", ^{
            [subject addMenuItemWithItemIcon:WKMenuItemIconResume title:@"asdf" action:@selector(init)];

            subject should have_received(@selector(addMenuItemWithItemIcon:title:action:)).with(WKMenuItemIconResume, @"asdf", @selector(init));
        });

        it(@"should record the invocations of clearAllMenuItems", ^{
            [subject clearAllMenuItems];

            subject should have_received(@selector(clearAllMenuItems));
        });

        it(@"should record the invocations of updateUserActivity:userInfo:", ^{
            [subject updateUserActivity:@"asdf" userInfo:@{@"a": @"b"}];

            subject should have_received(@selector(updateUserActivity:userInfo:)).with(@"asdf", @{@"a": @"b"});
        });
    });

    describe(@"triggering an interface object's segue", ^{
        describe(@"push action", ^{
            __block WKInterfaceButton *seguePushButton;
            beforeEach(^{
                seguePushButton = subject.seguePushButton;
                seguePushButton.segue should_not be_nil;
            });

            it(@"should have the correct segue configuration", ^{
                seguePushButton.segue.type should equal(FakeSegueTypePush);
            });

            it(@"should have the correct segue destination identifier", ^{
                seguePushButton.segue.destinationIdentifier should equal(@"MyFirstCorgiController");
            });
        });

        describe(@"modal action", ^{
            __block WKInterfaceButton *segueModalButton;
            beforeEach(^{
                segueModalButton = subject.segueModalButton;
                segueModalButton.segue should_not be_nil;
            });

            it(@"should have the correct segue configuration", ^{
                segueModalButton.segue.type should equal(FakeSegueTypeModal);
            });

            it(@"should have the correct segue destination identifier", ^{
                segueModalButton.segue.destinationIdentifier should equal(@"MyModalCorgiController");
            });
        });
    });
});

SPEC_END
