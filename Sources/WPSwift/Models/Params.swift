//
//  PagingParams.swift
//
//
//  Created by Ulaş Sancak on 30.06.2024.
//

import Foundation

public enum OrderType: String, Decodable, Sendable {
    case ascending = "asc"
    case descending = "desc"
}

extension [String: any Sendable] {
    static func createParamsForPost(categories: [Int] = [], categoriesToExclude: [Int] = [], tags: [Int] = [], tagsToExclude: [Int] = []) -> [String: any Sendable] {
        let categories = categories.map { "\($0)" }.joined(separator: ",")
        let categoriesToExclude = categoriesToExclude.map { "\($0)" }.joined(separator: ",")
        let tags = tags.map { "\($0)" }.joined(separator: ",")
        let tagsToExclude = tagsToExclude.map { "\($0)" }.joined(separator: ",")
        var params: [String: any Sendable] = [
            "_embed": "",
            "_fields":"id,date_gmt,modified_gmt,status,title,content,contentHTML,excerpt,author,featured_media,comment_status,categories,tags,link,_links"
        ]
        if !categories.isEmpty {
            params["categories"] = categories
        }
        if !categoriesToExclude.isEmpty {
            params["categories_exclude"] = categoriesToExclude
        }
        if !tags.isEmpty {
            params["tags"] = tags
        }
        if !tagsToExclude.isEmpty {
            params["tags_exclude"] = tagsToExclude
        }
        return params
    }
    
    static func createParamsForPosts(page: Int = 1, perPage: Int = 10, order: OrderType = .descending, categories: [Int]? = nil, categoriesToExclude: [Int]? = nil, tags: [Int]? = nil, tagsToExclude: [Int]? = nil, include: [Int]? = nil) -> [String: any Sendable] {
        let categories = categories?.map { "\($0)" }.joined(separator: ",")
        let categoriesToExclude = categoriesToExclude?.map { "\($0)" }.joined(separator: ",")
        let tags = tags?.map { "\($0)" }.joined(separator: ",")
        let tagsToExclude = tagsToExclude?.map { "\($0)" }.joined(separator: ",")
        let include = include?.map { "\($0)" }.joined(separator: ",")
        var params: [String: any Sendable] = [
            "page": page,
            "per_page": perPage,
            "order": order.rawValue,
            "_embed": "",
            "_fields":"id,date_gmt,modified_gmt,status,title,content,contentHTML,excerpt,author,featured_media,comment_status,categories,tags,link,_links"
        ]
        if let categories, !categories.isEmpty {
            params["categories"] = categories
        }
        if let categoriesToExclude, !categoriesToExclude.isEmpty {
            params["categories_exclude"] = categoriesToExclude
        }
        if let tags, !tags.isEmpty {
            params["tags"] = tags
        }
        if let tagsToExclude, !tagsToExclude.isEmpty {
            params["tags_exclude"] = tagsToExclude
        }
        if let include, !include.isEmpty {
            params["include"] = include
        }
        return params
    }
    
    static func createParamsForSearchPosts(term: String, page: Int = 1, perPage: Int = 10) -> [String: any Sendable] {
        [
            "search": term,
            "page": page,
            "per_page": perPage,
            "subtype": "post",
            "_fields":"id,title,url"
        ]
    }

    static func createParamsForCategories(page: Int = 1, perPage: Int = 100, order: OrderType = .descending) -> [String: any Sendable] {
        [
            "page": page,
            "per_page": perPage,
            "order": order.rawValue,
            "orderby": "count",
            "hide_empty": 1,
            "_fields":"id,count,description,link,name,parent"
        ]
    }
    
    static func createParamsForCategory() -> [String: any Sendable] {
        [
            "_fields":"id,count,description,link,name,parent"
        ]
    }
}
