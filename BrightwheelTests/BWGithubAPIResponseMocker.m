//
//  BWGithubAPIResponseMocker.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/27/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGithubAPIResponseMocker.h"
#import "BWGithubAPIClient.h"
#import "BWGithubRepo.h"
#import "BWGithubRepoContributor.h"
#import <objc/runtime.h>

@implementation BWGithubAPIResponseMocker

+ (NSDictionary *)validRepoDictionary {
    return @{
             @"id": @14077075,
             @"name": @"tacofancy",
             @"full_name": @"sinker/tacofancy",
             @"owner": @{
                 @"login": @"sinker",
                 @"id": @361410,
                 @"avatar_url": @"https://avatars.githubusercontent.com/u/361410?v=3",
                 @"gravatar_id": @"",
                 @"url": @"https://api.github.com/users/sinker",
                 @"html_url": @"https://github.com/sinker",
                 @"followers_url": @"https://api.github.com/users/sinker/followers",
                 @"following_url": @"https://api.github.com/users/sinker/following{/other_user}",
                 @"gists_url": @"https://api.github.com/users/sinker/gists{/gist_id}",
                 @"starred_url": @"https://api.github.com/users/sinker/starred{/owner}{/repo}",
                 @"subscriptions_url": @"https://api.github.com/users/sinker/subscriptions",
                 @"organizations_url": @"https://api.github.com/users/sinker/orgs",
                 @"repos_url": @"https://api.github.com/users/sinker/repos",
                 @"events_url": @"https://api.github.com/users/sinker/events{/privacy}",
                 @"received_events_url": @"https://api.github.com/users/sinker/received_events",
                 @"type": @"User",
                 @"site_admin": @NO
             },
             @"private": @NO,
             @"html_url": @"https://github.com/sinker/tacofancy",
             @"description": @"community-driven taco repo. stars stars stars.",
             @"fork": @NO,
             @"url": @"https://api.github.com/repos/sinker/tacofancy",
             @"forks_url": @"https://api.github.com/repos/sinker/tacofancy/forks",
             @"keys_url": @"https://api.github.com/repos/sinker/tacofancy/keys{/key_id}",
             @"collaborators_url": @"https://api.github.com/repos/sinker/tacofancy/collaborators{/collaborator}",
             @"teams_url": @"https://api.github.com/repos/sinker/tacofancy/teams",
             @"hooks_url": @"https://api.github.com/repos/sinker/tacofancy/hooks",
             @"issue_events_url": @"https://api.github.com/repos/sinker/tacofancy/issues/events{/number}",
             @"events_url": @"https://api.github.com/repos/sinker/tacofancy/events",
             @"assignees_url": @"https://api.github.com/repos/sinker/tacofancy/assignees{/user}",
             @"branches_url": @"https://api.github.com/repos/sinker/tacofancy/branches{/branch}",
             @"tags_url": @"https://api.github.com/repos/sinker/tacofancy/tags",
             @"blobs_url": @"https://api.github.com/repos/sinker/tacofancy/git/blobs{/sha}",
             @"git_tags_url": @"https://api.github.com/repos/sinker/tacofancy/git/tags{/sha}",
             @"git_refs_url": @"https://api.github.com/repos/sinker/tacofancy/git/refs{/sha}",
             @"trees_url": @"https://api.github.com/repos/sinker/tacofancy/git/trees{/sha}",
             @"statuses_url": @"https://api.github.com/repos/sinker/tacofancy/statuses/{sha}",
             @"languages_url": @"https://api.github.com/repos/sinker/tacofancy/languages",
             @"stargazers_url": @"https://api.github.com/repos/sinker/tacofancy/stargazers",
             @"contributors_url": @"https://api.github.com/repos/sinker/tacofancy/contributors",
             @"subscribers_url": @"https://api.github.com/repos/sinker/tacofancy/subscribers",
             @"subscription_url": @"https://api.github.com/repos/sinker/tacofancy/subscription",
             @"commits_url": @"https://api.github.com/repos/sinker/tacofancy/commits{/sha}",
             @"git_commits_url": @"https://api.github.com/repos/sinker/tacofancy/git/commits{/sha}",
             @"comments_url": @"https://api.github.com/repos/sinker/tacofancy/comments{/number}",
             @"issue_comment_url": @"https://api.github.com/repos/sinker/tacofancy/issues/comments{/number}",
             @"contents_url": @"https://api.github.com/repos/sinker/tacofancy/contents/{+path}",
             @"compare_url": @"https://api.github.com/repos/sinker/tacofancy/compare/{base}...{head}",
             @"merges_url": @"https://api.github.com/repos/sinker/tacofancy/merges",
             @"archive_url": @"https://api.github.com/repos/sinker/tacofancy/{archive_format}{/ref}",
             @"downloads_url": @"https://api.github.com/repos/sinker/tacofancy/downloads",
             @"issues_url": @"https://api.github.com/repos/sinker/tacofancy/issues{/number}",
             @"pulls_url": @"https://api.github.com/repos/sinker/tacofancy/pulls{/number}",
             @"milestones_url": @"https://api.github.com/repos/sinker/tacofancy/milestones{/number}",
             @"notifications_url": @"https://api.github.com/repos/sinker/tacofancy/notifications{?since,all,participating}",
             @"labels_url": @"https://api.github.com/repos/sinker/tacofancy/labels{/name}",
             @"releases_url": @"https://api.github.com/repos/sinker/tacofancy/releases{/id}",
             @"created_at": @"2013-11-02T23:35:45Z",
             @"updated_at": @"2015-09-19T16:44:05Z",
             @"pushed_at": @"2015-09-11T19:53:41Z",
             @"git_url": @"git://github.com/sinker/tacofancy.git",
             @"ssh_url": @"git@github.com:sinker/tacofancy.git",
             @"clone_url": @"https://github.com/sinker/tacofancy.git",
             @"svn_url": @"https://github.com/sinker/tacofancy",
             @"homepage": @"",
             @"size": @5809,
             @"stargazers_count": @856,
             @"watchers_count": @856,
             @"language": @"CoffeeScript",
             @"has_issues": @YES,
             @"has_downloads": @YES,
             @"has_wiki": @NO,
             @"has_pages": @NO,
             @"forks_count": @210,
             @"mirror_url": @"",
             @"open_issues_count": @5,
             @"forks": @210,
             @"open_issues": @5,
             @"watchers": @856,
             @"default_branch": @"master",
             @"score": @31.944477
             };
}

+ (NSDictionary *)repoDictionaryMissingFullName {
    NSDictionary *repo = [self validRepoDictionary];
    NSMutableDictionary *mutableRepo = [repo mutableCopy];
    [mutableRepo setObject:[NSNull null] forKey:@"full_name"];
    return mutableRepo;
}

+ (NSDictionary *)repoDictionaryMissingDescription {
    NSDictionary *repo = [self validRepoDictionary];
    NSMutableDictionary *mutableRepo = [repo mutableCopy];
    [mutableRepo setObject:[NSNull null] forKey:@"description"];
    return mutableRepo;
}

+ (NSDictionary *)repoDictionaryMissingOwnerLogin {
    NSDictionary *repo = [self validRepoDictionary];
    NSMutableDictionary *mutableRepo = [repo mutableCopy];
    [mutableRepo setObject:[NSNull null] forKey:@"owner"];
    return mutableRepo;
}

+ (NSArray *)validRepoArray {
    NSMutableArray *repos = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        [repos addObject:[self validRepoDictionary]];
    }
    return repos;
}

+ (NSArray *)repoArrayWithInvalidRepo {
    NSArray *repos = [self validRepoArray];
    NSMutableArray *mutableRepos = [repos mutableCopy];
    [mutableRepos addObject:@[]];
    return mutableRepos;
}

+ (NSDictionary *)validContributorDictionary {
    return @{
             @"avatar_url": @"https://avatars.githubusercontent.com/u/67395?v=3",
             @"contributions": @196,
             @"events_url": @"https://api.github.com/users/ProLoser/events{/privacy}",
             @"followers_url": @"https://api.github.com/users/ProLoser/followers",
             @"following_url": @"https://api.github.com/users/ProLoser/following{/other_user}",
             @"gists_url": @"https://api.github.com/users/ProLoser/gists{/gist_id}",
             @"gravatar_id": @"",
             @"html_url": @"https://github.com/ProLoser",
             @"id": @67395,
             @"login": @"ProLoser",
             @"organizations_url": @"https://api.github.com/users/ProLoser/orgs",
             @"received_events_url": @"https://api.github.com/users/ProLoser/received_events",
             @"repos_url": @"https://api.github.com/users/ProLoser/repos",
             @"site_admin": @0,
             @"starred_url": @"https://api.github.com/users/ProLoser/starred{/owner}{/repo}",
             @"subscriptions_url": @"https://api.github.com/users/ProLoser/subscriptions",
             @"type": @"User",
             @"url": @"https://api.github.com/users/ProLoser",
             };
}

+ (NSDictionary *)contributorDictionaryMissingLogin {
    NSDictionary *contributor = [self validContributorDictionary];
    NSMutableDictionary *mutableContributor = [contributor mutableCopy];
    [mutableContributor setObject:[NSNull null] forKey:@"login"];
    return mutableContributor;
}

+ (NSDictionary *)contributorDictionaryMissingContributions {
    NSDictionary *contributor = [self validContributorDictionary];
    NSMutableDictionary *mutableContributor = [contributor mutableCopy];
    [mutableContributor setObject:[NSNull null] forKey:@"contributions"];
    return mutableContributor;
}

@end
