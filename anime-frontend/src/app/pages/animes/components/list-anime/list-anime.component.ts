import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { Animes } from '../../entity/animes';
import { AnimesResponse } from '../../entity/animes-response';
import { AnimeService } from '../../services/anime.service';

@Component({
  selector: 'app-list-anime',
  templateUrl: './list-anime.component.html',
  styleUrls: ['./list-anime.component.scss']
})
export class ListAnimeComponent implements OnInit {

  animes: Animes[];
  animesList: Animes[] = [];
  animesFilterList: Animes[] = [];         // We Create It Second For Filter
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value
  suggestProgress = false;
  allAnimesObservable: Subscription;

  constructor(private animeService: AnimeService,
              private toaster: ToastrService ) { }

  ngOnInit() {
    this.getAnimes();
  }

  ngOnDestroy() {
    this.allAnimesObservable.unsubscribe();
  }

  getAnimes() {
    // Fetch All Animes
    this.allAnimesObservable = this.animeService.allAnimes().subscribe(
        (data: AnimesResponse) => {
          if (data) {
            // console.log('all Enimes :', data);
            this.animes = data.Data;
            this.animesList = data.Data;
          }
        },
        error1 => this.handleError(error1),
        () => {
          this.animesFilterList = this.animesList;
        });

    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.animesList.length
    };
  }

    // Handle Response Error
    handleError(error) {
      this.animes = [];
      console.log(error);
      if (error.error.error) {
        this.toaster.error(error.error.error);
      } else if (error.error.msg) {
        this.toaster.error(error.error.msg);
      }
    }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  suggest(animeID: number, isSuggest: boolean) {
    this.suggestProgress = true;
    console.log(animeID, isSuggest);
    this.animeService.animeSuggest(animeID, isSuggest).subscribe(
      (suggestResponse) => {
        this.getAnimes();
        this.suggestProgress = false;
      },
      error => console.log(error)
    );
  }

  // Delete The Anime
  delete(animeId: number) {
    if (confirm('Are You Sure You Want To Delete This Anime')) {
      this.isDeleted = true;
      this.animeService.deleteAnime(animeId).subscribe(
        data => {
          this.toaster.success('Anime Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getAnimes();
        }
      );
    } else {
      return false;
    }
  }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.animesFilterList = [...this.animesList];
    } else {
      this.animesFilterList = [];
      this.animesFilterList = this.animesList.filter(res => {
        if (res.name) {
          const nameResult = res.name.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (nameResult) {
            // display the Name Column
            return nameResult;
          }
        }
        if (res.updatedBy) {
          const updatedBy = res.updatedBy.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (updatedBy) {
            // display the Name Column
            return updatedBy;
          }
        }
        if (res.createdBy) {
          const createdBy = res.createdBy.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (createdBy) {
            // display the Name Column
            return createdBy;
          }
        }
      });
    }
  }
}
