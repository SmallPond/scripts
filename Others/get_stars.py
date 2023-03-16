# 此脚本完全由 ChatGPT 完成
# 如使用有问题，与本人无关（狗头
import argparse
import requests

# 创建命令行参数解析器
parser = argparse.ArgumentParser(description="Get the number of stars for a user's repositories on GitHub.")
parser.add_argument("username", help="GitHub username")
args = parser.parse_args()

# 获取用户名
username = args.username

# 构造 API 请求 URL，包括分页信息
url = f"https://api.github.com/users/{username}/repos?per_page=100&page=1"

# 发送 API 请求，并获取响应
star_count = 0
repo_info = []
while url:
    response = requests.get(url)
    if response.status_code == 200:
        # 解析 API 响应，输出每个仓库的 star 数量，并统计所有仓库获得的 star 数量
        repos = response.json()
        for repo in repos:
            repo_name = repo["name"]
            repo_star_count = repo["stargazers_count"]
            if repo_star_count > 0:
                repo_info.append((repo_star_count, repo_name))
                star_count += repo_star_count
        # 检查是否有更多页，如果有，更新 API 请求 URL
        links = response.headers.get("Link")
        url = None
        if links:
            for link in links.split(","):
                if "rel=\"next\"" in link:
                    url = link[link.index("<")+1:link.index(">")]
                    break
    else:
        # 如果请求失败，输出错误信息
        print(f"Error: Failed to retrieve repository data (status code: {response.status_code}).")
        exit()

# 按 star 数量递减排序
repo_info.sort(reverse=True)

# 输出每个仓库的 star 数量
print("Repository star count:")
for repo_star_count, repo_name in repo_info:
    print(f"{repo_star_count:>7} {repo_name}")

# 输出该用户所有仓库获得的 star 数量
print(f"\nTotal star count: {star_count}")
